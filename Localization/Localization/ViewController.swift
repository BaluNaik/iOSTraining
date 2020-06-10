//
//  ViewController.swift
//  Localization
//
//  Created by Balu Naik on 6/10/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "home".localized
    }
    
    // MARK: - Button Actions
    
    @IBAction func navigateToDetails(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "Details") as? DetailsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func switchLanguage(_ sender: UIButton) {
        if LanguageManager.getCurrentLanguage() == "en" {
            LanguageManager.setLanguage(language: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            LanguageManager.setLanguage(language: "en")
             UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        if let rootWindow = UIApplication.shared.windows.first {
            rootWindow.rootViewController = self.storyboard?.instantiateViewController(identifier: "RootScreen")
            UIView.transition(with: rootWindow, duration: 0.533, options: .transitionFlipFromLeft, animations: {
                
            }, completion: nil)
        }
    }

}

