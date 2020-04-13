//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by Balu Naik on 4/13/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("1.willFinishLaunchingWithOptions")
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("2.didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("3.applicationDidBecomeActive")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("we dont have URL so it will not called")
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("4.applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("5.applicationWillEnterForeground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("6.applicationWillTerminate")
    }
    

}
/*
    Keypoints
 About AppDelegate
 1. This class is supposed to be there to handle application lifecycle events - i.e., responding to the app being launched, backgrounded, foregrounded, receiving data, and so on
 2. Its a singleton class i.e. only 1 instance is created
 
 About UIResponder
 1. UIResponder is a subclass of NSObject
 2. it will handle chain of events
 
 About UIApplicationDelegate
 1. its a protocal having list of empty methods for app life cycle
 
 window object provides surface for the app to load UI
 
 */

