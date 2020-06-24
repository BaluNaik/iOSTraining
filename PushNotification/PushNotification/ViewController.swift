//
//  ViewController.swift
//  PushNotification
//
//  Created by Balu Naik on 6/22/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apsData:[String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Check if app launch from notification or we recived a notification
        if let aps = apsData {
            processNotification(aps: aps);
        }
    }
    
    func processNotification(aps: [String: Any]) {
        let alertController = UIAlertController(title: aps["category"] as? String, message: aps["alert"] as? String, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        clearNotification()
    }
    
    func clearNotification() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let notification = UNUserNotificationCenter.current()
        notification.removeAllDeliveredNotifications()
        notification.removeAllPendingNotificationRequests()
    }


}

