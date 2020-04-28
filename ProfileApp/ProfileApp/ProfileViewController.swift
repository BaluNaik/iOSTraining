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
        
    }

}

