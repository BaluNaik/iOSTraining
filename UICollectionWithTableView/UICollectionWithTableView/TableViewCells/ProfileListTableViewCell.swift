//
//  ProfileListTableViewCell.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ProfileListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    var profileName: String? {
        didSet {
            if let name = profileName {
                profileNameLabel.text = name
            }
            if let name = profileName,
                let pickName = ProfileDataAPI.sharedInstance.getProfilePreFix(name: name) {
                if let image = UIImage(named: pickName + "1") {
                    profileImageView.image = image
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 45
        profileImageView.clipsToBounds = true
    }

}
