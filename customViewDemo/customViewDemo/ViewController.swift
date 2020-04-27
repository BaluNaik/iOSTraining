//
//  ViewController.swift
//  customViewDemo
//
//  Created by Balu Naik on 4/24/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var formView: FormView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.formView.delegate = self
    }


}


//MARK: - FormViewDelegate

extension ViewController: FormViewDelegate {
    
    func submitData(data: [String : String]) {
        print(data)
        print(data["fName"])
        print(data["email"])
        print(data["lName"])
        print(data["dob"])
    }
.
}

