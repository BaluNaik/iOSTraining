//
//  ProfileDataAPITest.swift
//  ProfileAppTests
//
//  Created by Balu Naik on 6/16/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import XCTest

class ProfileDataAPITest: ProfileAppBaseTest {
    
    func checkDateFormat(_ dob: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        return formatter.date(from: dob)
    }
    
    
    func testProfileList() {
        let profileList = ProfileDataAPI.getProfile()
        XCTAssertNotNil(profileList)
        XCTAssertEqual(profileList.count, 10, "10 profiles should be required")
        
        
        let firstProfile = profileList[0]
        XCTAssertEqual(firstProfile.name, "Narendra Modi", "Name Must Be Narendra Modi")
        XCTAssertEqual(firstProfile.jobTitle, "Prime Minister of India", "Job Must Be Prime Minister of India")
        XCTAssertNotNil(firstProfile.country)
        
        //XCTAssertNil(checkDateFormat("Sep 17, 1950"), "Should be invalid format Date")
        XCTAssertNotNil(checkDateFormat("September 17, 1950"), "Should be valid format Date")
    }
    
    func testImageService() {
        let image = UIImage(named: "Ronaldinho")
        if let imageTosave = image {
            let savedStatus = ProfileDataAPI.saveImageInDocumentDir(image: imageTosave, name: "Ronaldinho_Test")
            XCTAssertTrue(savedStatus, "Ohooo image was not saved")
        }
        
        let savedImage = ProfileDataAPI.getImage(name: "Ronaldinho_Test")
        XCTAssertNotNil(savedImage)
    }
    
}
