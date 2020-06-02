//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Balu Naik on 6/1/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tabelView: UITableView!
    //private var commits = [Commit]()
    var fetchedResultsController: NSFetchedResultsController<Commit>?
    var commitPredicate: NSPredicate?
    
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataApp")
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(changeFilter))

        performSelector(inBackground: #selector(featchCommits), with: nil)
        loadCommits()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            self.tabelView.deleteRows(at: [indexPath!], with: .automatic)

        default:
            break
        }
    }
   
    @objc func changeFilter() {
        let alertCOntroller = UIAlertController(title: "Filter commits…", message: nil, preferredStyle: .actionSheet)

        // 1
        alertCOntroller.addAction(UIAlertAction(title: "Show only fixes", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "message CONTAINS[c] 'fix'")
            self.loadCommits()
        })

        // 2
        alertCOntroller.addAction(UIAlertAction(title: "Ignore Pull Requests", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "NOT message BEGINSWITH 'Merge pull request'")
            self.loadCommits()
        })

        // 3
        alertCOntroller.addAction(UIAlertAction(title: "Show only recent", style: .default) { [unowned self] _ in
            let twelveHoursAgo = Date().addingTimeInterval(-43200)
            self.commitPredicate = NSPredicate(format: "date > %@", twelveHoursAgo as NSDate)
            self.loadCommits()
        })

        // 4
        alertCOntroller.addAction(UIAlertAction(title: "Show only Durian commits", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "author.name == 'Joe Groff'")
            self.loadCommits()
        })

        // 5
        alertCOntroller.addAction(UIAlertAction(title: "Show all commits", style: .default) { [unowned self] _ in
            self.commitPredicate = nil
            self.loadCommits()
        })

        alertCOntroller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertCOntroller, animated: true)
    }

}


// MARK: - Core Data Helper

extension ViewController {
    
    func loadCommits() {
//        let fetchRequest = Commit.createFetchRequest()
//        let sort = NSSortDescriptor(key: "date", ascending: false)
//        fetchRequest.sortDescriptors = [sort]
//
//        if let commits = try? self.persistentContainer.viewContext.fetch(fetchRequest) {
//            if commits.count > 0 {
//                self.commits = commits
//            }
//        }
//        self.tabelView.reloadData()
        if fetchedResultsController == nil {
            let request = Commit.createFetchRequest()
            let sort = NSSortDescriptor(key: "author.name", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: "author.name", cacheName: nil)
            fetchedResultsController?.delegate = self
        }
        fetchedResultsController?.fetchRequest.predicate = commitPredicate

        do {
            try fetchedResultsController?.performFetch()
            self.tabelView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    @objc func featchCommits() {
        let lastupdateDate = getNewestCommitDate()
        
        if let url = URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100&since=\(lastupdateDate)"),
            let dataString = try? String(contentsOf:url) {
            let jsonCommits = JSON(parseJSON: dataString)
            let jsonArrayCommits = jsonCommits.arrayValue
            print("\nData Recived: \(jsonArrayCommits.count)")
            DispatchQueue.main.async {[unowned self] in
                for jsonCommit in jsonArrayCommits {
                    let commit = Commit(context: self.persistentContainer.viewContext)
                    self.configCommitData(commit: commit, usingJSON: jsonCommit)
                }
                self.saveContext()
                self.loadCommits()
            }
        }
    }
    
    func configCommitData(commit: Commit, usingJSON json: JSON) {
        commit.sha = json["sha"].stringValue
        commit.message = json["commit"]["message"].stringValue
        commit.url = json["html_url"].stringValue
        
        let formatter = ISO8601DateFormatter()
        commit.date = formatter.date(from: json["commit"]["committer"]["date"].stringValue) ?? Date()
        
        // one author can have multiple commits
        // But all commits can belongs to a single author so we need to manage only one author record in db
        //Check this author is there in DB, if yes, jsut link author record to commit
        
        var commitAuthor: Author!
        
        // see if this author exists already
        let authorRequest = Author.createFetchRequest()
        authorRequest.predicate = NSPredicate(format: "name == %@", json["commit"]["committer"]["name"].stringValue)
        
        if let authors = try?  persistentContainer.viewContext.fetch(authorRequest) {
            if authors.count > 0 {
                // we have this author already
                commitAuthor = authors[0]
            }
        }
        
        if commitAuthor == nil {
            // we didn't find a saved author - create a new one!
            let author = Author(context: persistentContainer.viewContext)
            author.name = json["commit"]["committer"]["name"].stringValue
            author.email = json["commit"]["committer"]["email"].stringValue
            commitAuthor = author
        }
        
        // use the author, either saved or new
        commit.author = commitAuthor
    }
    
    func getNewestCommitDate() -> String {
        
        let formatter = ISO8601DateFormatter()  //("yyyy-MM-dd'T'HH:mm:ssXXXXX")
        
        let newest = Commit.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        newest.sortDescriptors = [sort]
        newest.fetchLimit = 1
        
        if let commits = try? self.persistentContainer.viewContext.fetch(newest) {
            if commits.count > 0,
                let date = commits[0].date {  // First record date and time
                
                return formatter.string(from: date.addingTimeInterval(1))
            }
        }
        
        return formatter.string(from: Date(timeIntervalSince1970: 0))  //old date
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.fetchedResultsController?.sections?.count ?? 0   //return 1;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = fetchedResultsController?.sections?[section]
        
        return sectionInfo?.numberOfObjects ?? 0  //return self.commits.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = self.commits[indexPath.row].author?.name ?? ""
        //cell.detailTextLabel?.text = self.commits[indexPath.row].message ?? ""
        
        let commit = fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = commit?.message
        cell.detailTextLabel?.text = "By \(commit?.author?.name ?? "") on \(commit?.date?.description ?? "")"

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let commit = fetchedResultsController?.object(at: indexPath) {
                fetchedResultsController?.managedObjectContext.delete(commit)
                //self.persistentContainer.viewContext.delete(commit)
                saveContext()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.detailItem = fetchedResultsController?.object(at: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return fetchedResultsController?.sections![section].name
    }
}

