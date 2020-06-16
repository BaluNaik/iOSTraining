//
//  ProfileTest.swift
//  ProfileAppTests
//
//  Created by Balu Naik on 6/16/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import XCTest

class ProfileTest: ProfileAppBaseTest {
    
    func testProfile() {
        let newProfile = Profile(name: "Balu Naik", jobTitle: nil, country: "India", dob: nil)
        
        XCTAssertEqual(newProfile.name, "Balu Naik")
        XCTAssertNil(newProfile.jobTitle, "Job should be nil")
        XCTAssertEqual(newProfile.country, "India", "Country should be India")
        XCTAssertNil(newProfile.dob)
        
        let updatedProfile = Profile(name: "Balu Naik", jobTitle: "Sr.iOS Dev", country: "India", dob: "04 Jun 1988")
        XCTAssertNotNil(updatedProfile)
        XCTAssertEqual(updatedProfile.name, "Balu Naik")
        XCTAssertEqual(updatedProfile.jobTitle, "Sr.iOS Dev", "Job should be Sr.iOS Dev")
        XCTAssertEqual(updatedProfile.country, "India", "Country should be India")
        XCTAssertNotNil(updatedProfile.dob)
    }

}
