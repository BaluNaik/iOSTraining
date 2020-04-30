//
//  ProfileViewController.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    let profileList = ProfileDataAPI.getProfile() // Returns list of profile

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
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = editButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewProfile))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    // MARK: - Action
    
    @objc private func addNewProfile() {
        if let vc = self.storyboard?.instantiateViewController(identifier: "ProfileDetailsScreen") as? ProfileDetailsScreen {
            vc.pageType = .Add
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.profileList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell {
            profileCell.profileData = self.profileList[indexPath.section]
            cell = profileCell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "ProfileDetailsScreen") as? ProfileDetailsScreen {
            vc.profileData = self.profileList[indexPath.section]
            vc.pageType = .Show
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

