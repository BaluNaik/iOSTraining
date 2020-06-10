//
//  DetailsViewController.swift
//  Localization
//
//  Created by Balu Naik on 6/10/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var leable: UILabel!
    @IBOutlet weak var imageview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "details".localized
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.leable.text = "hand_sign".localized
        self.textField.text = "hand_sign".localized
        self.textField.textAlignment = UIApplication.isRTL() ? NSTextAlignment.right : NSTextAlignment.left
        self.textField.layoutIfNeeded()
        if LanguageManager.getCurrentLanguage() == "ar" {
            // Load differnt image
           // self.imageview.transform = imageview.transform.rotated(by:2 )
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
