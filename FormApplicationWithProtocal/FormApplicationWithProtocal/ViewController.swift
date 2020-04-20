//
//  ViewController.swift
//  FormApplicationWithProtocal
//
//  Created by Balu Naik on 4/20/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: BTButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        button.showEnabled()
    }

}

