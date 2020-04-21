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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let receiverVC = segue.destination as? EmpFormViewController {
            receiverVC.delegate = self  // thats means call back is implemented in this class
        }
    }


}

// MARK: - FormViewControllerDelegate

extension ViewController: FormViewControllerDelegate {
    
    func submitDate(data: Emp) {
        // Now data will get in data parameter
        
    }
    
}

