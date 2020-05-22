//
//  HomeTableViewController.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var modelDataProvider: HomeDataProvider?
    private var rowCount: Int = 0
    private var currentpage = 1
    private var loadingInProgress = false
    private var canLoadNextPage = true
    var loader: UIActivityIndicatorView?
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLoader()
        self.modelDataProvider = HomeDataProvider()
        self.modelDataProvider?.delegate = self
        self.modelDataProvider?.getBreedList(for: self.currentpage)
        self.searchBar.delegate = self
        self.title = "CAT BREED"
    }
    func setupMainLoader() {
        self.loader = UIActivityIndicatorView(style: .large)
        self.loader?.color = UIColor.black
        self.loader?.frame = CGRect(origin: CGPoint(x: self.view.frame.size.width / 2 - 60, y: self.view.frame.height / 2 - 60), size: CGSize(width: 60.0, height: 60))
        if let loaderView = self.loader {
            self.view.addSubview(loaderView)
            loaderView.hidesWhenStopped = true
        }
    }
    
    func loadNextPage() {
        if loadingInProgress || canLoadNextPage == false {
            return
        }
        currentpage = currentpage + 1
        self.modelDataProvider?.getBreedList(for: self.currentpage)
        self.loadingInProgress = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowCount = self.modelDataProvider?.getBreddCount() ?? 0
         
        return rowCount > 0 && canLoadNextPage ? rowCount + 1 : rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if canLoadNextPage && indexPath.row == rowCount {  //it's last row we have to show loader
            if let loaderCell = tableView.dequeueReusableCell(withIdentifier: "loaderCell", for: indexPath) as? LoaderTableViewCell {
                cell = loaderCell
            }
        } else {
            let breedCell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)
            if let breed = self.modelDataProvider?.getBreedInformation(for: indexPath.row) {
                breedCell.textLabel?.text = breed.name ?? ""
                breedCell.detailTextLabel?.text = breed.origin ?? ""
            }
            cell = breedCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let loaderCell = cell as? LoaderTableViewCell {
            loaderCell.startAnimating()
            self.loadNextPage()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let breed = self.modelDataProvider?.getBreedInformation(for: indexPath.row),
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            vc.breed = breed
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// Mark: - HomeDataProviderProtocal

extension HomeTableViewController: HomeDataProviderProtocal {
    
    func updateContent() {
        if loadingInProgress {
            self.loadingInProgress = false
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.showErrorAlert(message)
        }
    }
    
    func showLoader(_ show: Bool) {
        DispatchQueue.main.async {
            if show {
                self.loader?.startAnimating()
                self.tableView.isUserInteractionEnabled = false
            } else {
                self.loader?.stopAnimating()
                self.tableView.isUserInteractionEnabled = true
            }
        }
    }
    
    func stopLoadingNextPage() {
        self.canLoadNextPage = false
        self.updateContent()
    }
    
}


// MARK: - UISearchBarDelegate

extension HomeTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)
        if !searchText.isEmpty {
             self.modelDataProvider?.searchBreeds(for: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // called when keyboard search button pressed
        if let text = searchBar.text, text.isEmpty {
            searchBar.resignFirstResponder()
            self.modelDataProvider?.getBreedList(for: 1)
        }
    }
}
