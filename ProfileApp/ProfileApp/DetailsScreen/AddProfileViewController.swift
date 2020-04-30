//
//  AddProfileViewController.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/29/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class AddProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var jobTextFiled: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    private var datePicker: UIDatePicker?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pickerView.isHidden = true
        self.profileImageView.backgroundColor = UIColor.lightGray
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
        submitButton.layer.cornerRadius = 4
        submitButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func showDatePicker() {
        if let picker = datePicker {
            dobTextField.inputView = picker
        } else {
            datePicker = UIDatePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 200, width: self.view.frame.size.width, height: 200))
            datePicker?.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
            datePicker?.datePickerMode = .date
            datePicker?.maximumDate = setMaxDate()
            dobTextField.inputView = datePicker
            datePicker?.addTarget(self, action: #selector(datePickerValueChange), for: .valueChanged)
            let toolBar = UIToolbar()
            toolBar.backgroundColor = UIColor.systemPink
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target:self, action: #selector(doneClicked))
            let closeButton = UIBarButtonItem(title: "Close", style: .done, target:self, action: #selector(closeClicked))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolBar.setItems([closeButton,flexibleSpace,doneButton], animated: true)
            dobTextField.inputAccessoryView = toolBar
        }
    }
    
    private func setMaxDate() -> Date {
         let currentCalendar = Calendar.current
         var component = currentCalendar.dateComponents([.year, .month, .day], from: Date())
         let minAgeYear = 18
         if let currentYear = component.year {
             component.year = (currentYear - minAgeYear)
         }
     
         return currentCalendar.date(from: component) ?? Date()
     }
    
    @objc func datePickerValueChange() {
        dobTextField.text = datePicker?.date.getFormattedDate()
    }
    
    @objc func doneClicked() {
        dobTextField.text = datePicker?.date.getFormattedDate()
        self.dobTextField.endEditing(true)
    }
    
    @objc func closeClicked() {
        self.dobTextField.endEditing(true)
    }

}

// MARK: - UITextFieldDelegate

extension AddProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == jobTextFiled || textField == countryTextField {
            //show picker for this fields
            //TODO: Need pickerview design
             return true
        }
        else if textField == dobTextField {
            textField.resignFirstResponder()
            showDatePicker()
            
            return true
        }
        
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            jobTextFiled.becomeFirstResponder()
        } else if textField == jobTextFiled {
            dobTextField.becomeFirstResponder()
        } else if textField == dobTextField {
            countryTextField.becomeFirstResponder()
        } else if textField == countryTextField {
            countryTextField.resignFirstResponder()
        }
        
        return true
    }
    
}


// MARK: - Date

extension Date {
    
    func getFormattedDate() -> String {
        //"April 24, 1973"
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        return formatter.string(from: self)
    }
}
