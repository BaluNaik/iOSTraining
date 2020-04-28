//
//  ProfileTableViewCell.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileAgeLabel: UILabel!
    @IBOutlet weak var profileJobLabel: UILabel!
    @IBOutlet weak var profileCountryImageView: UIImageView!
    
    var profileData: Profile? {
        didSet {
            guard let data = profileData  else { return }
            if let name = data.name {
                profileNameLabel.text = name
            }
            if let age = data.dob {
                profileAgeLabel.text = "\(getAgeFromDob(birthday:age)) Year"
            }
            if let job = data.jobTitle {
                profileJobLabel.text = job
            }
            if let profilePic = data.name {
                profileImageView.image = UIImage(named: profilePic)
            }
            if let flag = data.country {
                profileCountryImageView.image = UIImage(named: flag)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 45
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getAgeFromDob(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd, yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        if let calendar: NSCalendar = NSCalendar(calendarIdentifier: .gregorian) {
            let now = Date()
            let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
            let age = calcAge.year
            
            return age ?? 0
        }
        
        return 0
    }

}
