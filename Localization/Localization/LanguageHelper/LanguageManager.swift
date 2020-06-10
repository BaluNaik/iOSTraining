//
//  LanguageManager.swift
//  Localization
//
//  Created by Balu Naik on 6/10/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

let APPLE_LANGUAGE_KEY = "AppleLanguages"

/*
    - LanguageManager
    - It's responsible for getting/setting language from the UserDefaults.
 */
class LanguageManager {
    
    // Get apple language
    class func getCurrentLanguage() -> String {
        let userDefault = UserDefaults.standard
        if let languageArray = userDefault.object(forKey: APPLE_LANGUAGE_KEY) as? NSArray,
            let currentLanguage = languageArray.firstObject as? String {
            
            return currentLanguage
        }
        
        return "en"
    }
    
    // Set language when user changes it
    
    class func setLanguage( language: String) {
        let userdef = UserDefaults.standard
        userdef.set([language, getCurrentLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
}

extension String {

    var localized: String {
        get {
            if let path = Bundle.main.path(forResource: LanguageManager.getCurrentLanguage(), ofType: "lproj"),
                let bundle = Bundle(path: path) {
                
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
            
            return ""
        }
        set {}
    }
    
}
