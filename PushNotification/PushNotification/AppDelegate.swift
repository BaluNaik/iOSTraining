//
//  AppDelegate.swift
//  PushNotification
//
//  Created by Balu Naik on 6/22/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        requestNotificationAuthorization()
        
        // If app launch from remote notification
        if let notificationOption = launchOptions?[.remoteNotification],
            let notification = notificationOption as? [String: AnyObject],
            let aps = notification["aps"] as? [String: Any] {
            let window = UIApplication.shared.windows.first
            let vc = window?.rootViewController as? ViewController
            vc?.apsData = aps
        }
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


}


// MARK: - Push Notification work

extension AppDelegate {
    
    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification Setting:\(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    private func requestNotificationAuthorization() {
         // Request for permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert,.badge]) {[weak self] (granted, error) in
            print("Notification granted:\(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
        }
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenPart = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenPart.joined()
        print("Device Token:", token);
        // This token has to send backend server or push patners
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error registering notifications:\(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Every push notification have same structure i.e. root level key is 'aps'
        guard let aps = userInfo["aps"] as? [String: Any] else {
            
            completionHandler(.failed)
            return
        }
        //Yes we got a notification and have aps structure
        //Then we should process this notification depends on our requirement
        
        //TODO:
        let window = UIApplication.shared.windows.first
        let vc = window?.rootViewController as? ViewController
        vc?.apsData = aps
    }
    
    // Rich push action handler
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "Like" {
            // Do something on like button click
        } else if(response.actionIdentifier == "Open") {
            //Do something on Open action
        }
        completionHandler()
    }
    
}

