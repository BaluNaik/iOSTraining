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

class ViewController: UIViewController {
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataApp")
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
        performSelector(inBackground: #selector(featchCommits), with: nil)
        //Load from local
    }

}


// MARK: - Core Data Helper

extension ViewController {
    
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
                //TODO: Load data on UI
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
        
        // see if this author exists already
        let authorRequest = Author.createFetchRequest()
        authorRequest.predicate = NSPredicate(format: "name == %@", json["commit"]["author"]["name"].stringValue)
        
        if let authors = try? persistentContainer.viewContext.fetch(authorRequest) {
            if authors.count > 0 {
                commit.author = authors[0]
            }
        }
        if commit.author == nil {
            //We dont have record for this author
            let author = Author(context: persistentContainer.viewContext)
            author.name = json["commit"]["author"]["name"].stringValue
            author.email = json["commit"]["author"]["email"].stringValue
             commit.author = author
        }
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

