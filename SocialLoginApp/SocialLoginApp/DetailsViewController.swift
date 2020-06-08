//
//  DetailsViewController.swift
//  SocialLoginApp
//
//  Created by Balu Naik on 6/8/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

enum LoginType {
    case Google
    case FaceBook
    case Apple
    case None
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var informationLabel: UILabel!
    var loginType:LoginType = .None
    var userInfo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.informationLabel.text = userInfo
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        if loginType == .Google {
            GIDSignIn.sharedInstance().signOut()
        } else if loginType == .FaceBook {
            LoginManager().logOut()
        }
        self.navigationController?.popViewController(animated: true)
    }

}
