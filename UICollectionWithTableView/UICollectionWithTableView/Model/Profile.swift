//
//  Profile.swift
//  UICollectionWithTableView
//
//  Created by Balu Naik on 5/7/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

struct Profile {
    
    var name: String?
    var biography: String?
    var twitter: String?
    
    init(profileName: String, biographyText: String,twitterHandler: String) {
        self.name = profileName
        self.biography = biographyText
        self.twitter = twitterHandler
    }
}
