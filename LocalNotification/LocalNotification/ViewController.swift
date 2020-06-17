//
//  ViewController.swift
//  LocalNotification
//
//  Created by Balu Naik on 6/17/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            // On error we can show app setting page
        }
        
        // Step 2: Create the notification content
        
        let content = UNMutableNotificationContent()
        content.title = "Hey!!! It's a Notification"
        content.body = "Look At Me!!!"
//        if let attachment = try? UNNotificationAttachment(identifier: "image", url: URL(string: "https://i1.wp.com/balututorial.com/wp-content/uploads/2019/06/swift-logo.png?ssl=1")!, options: [:]) {
//            content.attachments = [attachment]
//        }
//
        // Step 3: Create the notification trigger
        let date = Date().addingTimeInterval(10)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Step 4: Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            //Check the error for any problem
        }
    }


}

