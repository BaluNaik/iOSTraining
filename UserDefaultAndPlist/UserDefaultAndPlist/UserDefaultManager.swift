//
//  UserDefaultManager.swift
//  UserDefaultAndPlist
//
//  Created by Balu Naik on 5/26/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

struct User {
    var userName: String?
    var password: String?
}

class UserDefaultManager {
    
    static var sharedInstance = UserDefaultManager()
    private var userDefault = UserDefaults.standard
    
    private init() { } // it will not allow to create another instance
    
    func setUser(user: User) {
        guard let userName = user.userName,
            let password = user.password else {
                
                return
        }
        self.userDefault.set(userName, forKey: "User")
        self.userDefault.set(password, forKey: "Pswd")
    }
    
    func getUser() -> User? {
        guard let user = self.userDefault.value(forKey: "User") as? String,
            let password = self.userDefault.value(forKey: "Pswd") as? String else {
            
                return nil
        }
        
        return User(userName: user, password: password)
    }
    
    func removeUser( user: String) {
        self.userDefault.removeObject(forKey: "User")
        self.userDefault.removeObject(forKey: "Pswd")
    }
}
