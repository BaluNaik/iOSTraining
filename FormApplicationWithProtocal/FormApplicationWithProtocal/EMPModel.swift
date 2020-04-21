//
//  EMPModel.swift
//  FormApplicationWithProtocal
//
//  Created by Balu Naik on 4/21/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class Emp: NSObject {
    var fName: String?
    var lName: String?
    var email: String?
    var gender: String?
    var dob: String?
    
    init(firstName: String,
         lastName: String,
         email: String,
         gender: String,
         dob: String) {
        super.init()
        self.fName = firstName
        self.lName = lastName
        self.email = email
        self.gender = gender
        self.dob = dob
    }
    
}
