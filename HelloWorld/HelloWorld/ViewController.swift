//
//  ViewController.swift
//  HelloWorld
//
//  Created by Balu Naik on 4/13/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionOnClick(_ sender: Any) {
        self.titleLabel.text = "Welcome"
        self.titleLabel.textColor = UIColor.red
        self.titleLabel.backgroundColor = UIColor.green
        self.view.backgroundColor = UIColor.red
        
        self.actionButton.backgroundColor = UIColor.yellow
        self.actionButton.isEnabled = false
    }
    
}

//UIViewController <- UIResponder <- NSObject
