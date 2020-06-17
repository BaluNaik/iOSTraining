//
//  ThirdViewController.swift
//  NotificationCenter
//
//  Created by Balu Naik on 6/17/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardshow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func actionOnButtonClick(_ sender: UIButton) {
        //Step2: Post notification from here
        NotificationCenter.default.post(name: NSNotification.Name.init("onButtonAction"), object: nil, userInfo: ["title" : "Balu Tutorial.com"])
    }
    
    @objc func onKeyboardshow() {
        let frame = self.view.frame
        self.view.frame = CGRect(x: frame.origin.x, y: frame.origin.y - 50, width: frame.size.width, height: frame.size.height)
    }
    
    @objc func onKeyboardHide() {
        let frame = self.view.frame
        self.view.frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}
