//
//  ProfileViewController.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    var profileList = ProfileDataAPI.getProfile() // Returns list of profile

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "profile".uppercased()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addBarButtons()
    }
    
    private func addBarButtons() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))
        self.navigationItem.leftBarButtonItem = editButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewProfile))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    // MARK: - Action
    
    @objc private func addNewProfile() {
        if let vc = self.storyboard?.instantiateViewController(identifier: "ProfileDetailsScreen") as? ProfileDetailsScreen {
            vc.pageType = .Add
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.profileList.count
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell {
            profileCell.profileData = self.profileList[indexPath.row]
            cell = profileCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "ProfileDetailsScreen") as? ProfileDetailsScreen {
            vc.profileData = self.profileList[indexPath.row]
            vc.pageType = .Show
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Type: 1
            /*
                self.profileList.remove(at: indexPath.row) // Delete from data source
                tableView.reloadData()
             */
            
            //Type2:
            tableView.beginUpdates()
            self.profileList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { (action, sourceView, _) in
            tableView.beginUpdates()
            self.profileList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        removeAction.image = UIImage(named: "icon_garbage")
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { (action, sourceView, _) in
            tableView.beginUpdates()
            self.profileList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        removeAction.image = UIImage(named: "icon_garbage")
        
        let testAction = UIContextualAction(style: .destructive, title: "Remove") { (action, sourceView, _) in
            tableView.beginUpdates()
            self.profileList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        testAction.image = UIImage(named: "icon_garbage")
        
        return UISwipeActionsConfiguration(actions: [removeAction,testAction])
    }

}


extension ProfileViewController: ProfileDetailsScreenDelegate {
    
    func saveNewprofile(data: Profile) {
        self.profileList.append(data)
        self.tableView.reloadData()
    }
}
