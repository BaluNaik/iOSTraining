//
//  AppDelegate.swift
//  BTGoogleMaps
//
//  Created by Balu Naik on 6/5/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyADFyAXegqyXpxZlhR8k0o_PcjtFrCWDFQ")
        GMSPlacesClient.provideAPIKey("AIzaSyADFyAXegqyXpxZlhR8k0o_PcjtFrCWDFQ")
        //readPropertyList()
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func readPropertyList() {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        if let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let plistXML = FileManager.default.contents(atPath: plistPath) {
            do {
                plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
                if let googlekey = plistData["GoogleKey"] as? String {
                    print(googlekey)
                    GMSServices.provideAPIKey(googlekey)
                    GMSPlacesClient.provideAPIKey(googlekey)
                }
            } catch {
                print("Error reading plist: \(error), format: \(propertyListFormat)")
            }
        }
    }
}

