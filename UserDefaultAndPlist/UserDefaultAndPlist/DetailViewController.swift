//
//  DetailViewController.swift
//  UserDefaultAndPlist
//
//  Created by Balu Naik on 5/26/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
            if let user = UserDefaultManager.sharedInstance.getUser(),
                let password = user.password, user.userName == detail {
                self.passwordField?.text = password
                self.passwordField?.isSecureTextEntry = false
            } else {
                self.passwordField?.text = ""
                self.passwordField?.isSecureTextEntry = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    @IBAction func saveAction() {
        if let pswd = self.passwordField.text {
            UserDefaultManager.sharedInstance.setUser(user: User(userName: self.detailItem, password: pswd))
        }
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteAction() {
        if let userName = self.detailItem {
            UserDefaultManager.sharedInstance.removeUser(user: userName)
        }
        self.navigationController?.popViewController(animated: true)
    }

}

