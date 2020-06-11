//
//  ProfileDataAPI.swift
//  DeeplinksApp
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

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
    
    static func saveImageInDocumentDir( image: UIImage, name: String) {
        // File Manger object
        let fileManger = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name + ".png")
        // it returns documentDirectory path and ammending new file to that path
        print(path)
        let imageData = image.jpegData(compressionQuality: 0.5)  // it converts image into data object(Data)
        fileManger.createFile(atPath: path, contents: imageData, attributes: nil)  // it will write image into device
    }
    
    static func getImage(name title: String) -> UIImage? {
        // File Manger object
        let fileManger = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(title + ".png")
        print(path)
        if fileManger.fileExists(atPath: path) {
            
            return UIImage(contentsOfFile: path)
        } else {
            
            return nil
        }
    }
    
}



  

  
  
   
  
