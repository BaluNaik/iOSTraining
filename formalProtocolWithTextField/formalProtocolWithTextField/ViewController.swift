//
//  ViewController.swift
//  formalProtocolWithTextField
//
//  Created by Balu Naik on 4/17/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButton.isEnabled = false
        //self.firstNameField.delegate = self
        //self.lastNameField.delegate = self
        self.firstNameField.returnKeyType = .next
        self.lastNameField.returnKeyType = .done
    }
    
    // MARK: - Private
    
    private func showAlertWithMessage(_ alertTitle: String, _ alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) {[weak self] (_) in
            if alertTitle == "Full Name" {
                self?.firstNameField.text = ""
                self?.lastNameField.text = ""
                self?.submitButton.isEnabled = false
            }
        }
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Action
    
    @IBAction func actionOnSubmit(_ sender: Any) {
        if let isValid = self.firstNameField.text?.isValidateLength(10), !isValid {
            self.showAlertWithMessage("Error!!", "First Name Max length is 10")
        } else if let isValid = self.lastNameField.text?.isValidateLength(10), !isValid {
            self.showAlertWithMessage("Error!!", "Last Name Max length is 10")
        } else {
            self.showAlertWithMessage("Full Name", "\(self.firstNameField.text ?? "") \(self.lastNameField.text ?? "")")
        }
    }
    
}


// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         // return NO to disallow editing.
        print("in textFieldShouldBeginEditing")
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("textFieldDidBeginEditing")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("textFieldDidEndEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("textFieldDidEndEditing")
        if self.firstNameField.text?.isEmpty ?? true || self.lastNameField.text?.isEmpty ?? true {
            self.submitButton.isEnabled = false
        } else {
            self.submitButton.isEnabled = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { //for back char
            
            return true
        }
        if let _ = string.rangeOfCharacter(from: .letters) { // only A-Z or a-z
            
            return true
        }
        
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("textFieldShouldClear")
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("textFieldShouldReturn")
        if textField == firstNameField {
            self.lastNameField.becomeFirstResponder() //opens keybaord
        } else {
            self.lastNameField.resignFirstResponder() //close keyboard
        }
        
        return true
    }
    
}

