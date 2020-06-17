//
//  SecondViewController.swift
//  NotificationCenter
//
//  Created by Balu Naik on 6/17/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Step1: Add Observer
        NotificationCenter.default.addObserver(self, selector: #selector(onMessagePass(notification:)), name: NSNotification.Name.init("onButtonAction"), object: nil)
    }
    
    deinit {
        //Step 4: We have to remove any notification on deinint of class
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("onButtonAction"), object: nil)
    }
    
    @objc func onMessagePass(notification: NSNotification) {
        if let titleMessage = notification.userInfo?["title"] as? String {
            self.titleLabel.text = titleMessage
        }
    }
}

