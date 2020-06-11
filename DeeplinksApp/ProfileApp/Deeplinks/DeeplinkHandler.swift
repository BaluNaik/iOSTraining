//
//  DeeplinkHandler.swift
//  DeeplinksApp
//
//  Created by Balu Naik on 6/11/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class DeeplinkHandler {
    
    static var redirectUrl: String?
    
    class func setUpDeeplinkRedirect(for url: URL) {
        // case1: DeeplinksApp://  --> this is default redirect to app
        // case2: DeeplinksApp://new_profile  --> it has to go new profile screen
        // case3: DeeplinksApp://profile=narendra_modi  --> it has to be land on  Narendra Modi profile
        if url.absoluteString.contains("new_profile") {
            redirectUrl = "NewProfile"
        } else if url.absoluteString.contains("profile=") {
            let subString = url.absoluteString.components(separatedBy: "=")
            if subString.count > 0 {
                redirectUrl = subString[1].replacingOccurrences(of: "_", with: " ")
            }
        }
    }
    
}
