//
//  ProfileDataAPI.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class ProfileDataAPI {
    
    static func getProfile() -> [Profile] {
        
        let profileList = [
            Profile(name: "Narendra Modi", jobTitle: "Prime Minister of India", country: "india", dob: "September 17, 1950"),
            Profile(name: "Sachin Tendulkar", jobTitle: "Indian cricketer", country: "india", dob: "April 24, 1973"),
            Profile(name: "Amitabh Bachchan", jobTitle: "Indian film actor", country: "india", dob: "October 11, 1942"),
            Profile(name: "Roger Federer", jobTitle: "Tennis player", country: "Switzerland", dob: "August 8, 1981"),
            Profile(name: "Barack Obama", jobTitle: "U.S. President", country: "USA", dob: "August 4, 1961"),
            Profile(name: "Michael Schumacher", jobTitle: "German racing driver", country: "Germany", dob: "January 3, 1969"),
            Profile(name: "Ronaldinho", jobTitle: "Footballer", country: "Brazil", dob: "March 21, 1980"),
            Profile(name: "LeBron James", jobTitle: "American basketball player", country: "USA", dob: "December 30, 1984"),
            Profile(name: "Satya Nadella", jobTitle: "Chief Executive Officer of Microsoft", country: "india", dob: "August 19, 1967"),
            Profile(name: "Sundar Pichai", jobTitle: "Chief Executive Officer of Alphabet", country: "india", dob: "June 10, 1972"),
        ]
        
        return profileList
    }
    
}



  

  
  
   
  
