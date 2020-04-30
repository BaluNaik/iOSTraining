//
//  ProfileShowViewController.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/29/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ProfileShowViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    var profileData: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDate()
    }
    
    private func setUpDate() {
        if let fullName = profileData?.name {
            self.nameLabel.text = fullName
        }
        if let job = profileData?.jobTitle {
            self.jobLabel.text = job
        }
        if let dob = profileData?.dob {
            self.dobLabel.text = dob
        }
        if let country = profileData?.country {
            self.countryLabel.text = country
        }
        if let image = profileData?.name {
            self.profileImage.image = UIImage(named: image)
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        }
    }

}
