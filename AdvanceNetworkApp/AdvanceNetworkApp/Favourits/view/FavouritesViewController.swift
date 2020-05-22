//
//  SecondViewController.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import IHProgressHUD

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var dataProvider = FavouritesDataProvider()
    var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBarButtons()
        self.dataProvider.delegate = self
        self.title = "My Favourites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataProvider.getFavouritesList()
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
    
    private func addBarButtons() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))
        self.navigationItem.leftBarButtonItem = editButton
    }
    
    @objc private func editAction() {
        self.tableView.isEditing = true
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneAction() {
        self.tableView.isEditing = false
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataProvider.favouritesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let myCell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavouritesTableViewCell {
            let data = self.dataProvider.getfavouritesInformation(for: indexPath.row)
            if let id = data.imageId,
                let date = data.createdAt {
                myCell.configCell(id, createdAt: date)
            }
            cell = myCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favouriteObject = self.dataProvider.getfavouritesInformation(for: indexPath.row)
            if let favId = favouriteObject.id {
                self.dataProvider.deleteFavourite(favouriteId: favId, sucess: {[weak self] in
                    //Done deleted
                    self?.showLoader(false)
                    DispatchQueue.main.async {
                        self?.tableView.beginUpdates()
                        self?.dataProvider.deleteFavouriteObject(for: indexPath.row)
                        self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                        self?.tableView.endUpdates()
                    }
                    
                }) { [weak self ](error) in
                    self?.showLoader(false)
                    self?.showError(error?.localizedDescription ?? "Some thing went wrong try later")
                    DispatchQueue.main.async {
                        self?.tableView.endEditing(true)
                    } 
                }
            }
        }
    }
    
}

// MARK: - HomeDataProviderProtocal

extension FavouritesViewController: FavouritesDataProviderProtocal {
    
    func updateContent() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.showErrorAlert(message)
        }
    }
    
//    func showLoader(_ show: Bool) {
//        DispatchQueue.main.async {
//            if show {
//                //IHProgressHUD.show(withStatus: "Loading....")
//            } else {
//                //IHProgressHUD.dismiss()
//            }
//        }
//    }
    
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
    
}
