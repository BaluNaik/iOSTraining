//
//  NewEmployeeVC.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

enum EmployeeFormType {
    case New
    case Update
}

class NewEmployeeVC: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    var presenter: NewEmployeePresenterInput?
    var formType = EmployeeFormType.New
    var empData: EMP?
    
    private let validator = Validator()
    @IBOutlet weak var firstNameField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var salaryField: SkyFloatingLabelTextField!
    @IBOutlet weak var joinDateField: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileField: SkyFloatingLabelTextField!
    @IBOutlet weak var aboutField: SkyFloatingLabelTextField!
    @IBOutlet weak var submitbutton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        salaryField.delegate = self
        joinDateField.delegate = self
        aboutField.delegate = self
        mobileField.delegate = self
        
        validator.registerField(firstNameField, rules: [RequiredRule()])
        validator.registerField(lastNameField, rules: [RequiredRule()])
        validator.registerField(emailField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(salaryField, rules: [RequiredRule(),AlphaNumericRule()])
        validator.registerField(joinDateField, rules: [RequiredRule(), RegexRule(regex: "^\\d{2}-\\d{2}-\\d{4}$", message: "Must be dd-mm-yyyy format")])
        validator.registerField(aboutField, rules: [RequiredRule()])
        validator.registerField(mobileField, rules: [RequiredRule(),AlphaNumericRule(),MaxLengthRule(length: 10, message: "Max 10 digits")])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.formType == .Update {
            if let obj = empData {
                self.firstNameField.text = obj.fistName ?? ""
                self.lastNameField.text = obj.lastName ?? ""
                self.emailField.text = obj.email ?? ""
                self.mobileField.text = obj.mobile ?? ""
                self.aboutField.text = obj.about ?? ""
                self.salaryField.text = "\(obj.salary ?? 0)"
                self.joinDateField.text = obj.jDate ?? ""
                self.submitbutton.setTitle("Update", for: .normal)
            }
        }
    }
    
    @IBAction func submit() {
        validator.validate(self)
    }
    
    func validationSuccessful() {
        let emp = EMP(empID: self.empData?.empID ?? nil , fistName: firstNameField.text ?? "",
                      lastName: lastNameField.text ?? "",
                      email: emailField.text ?? "",
                      mobile: mobileField.text ?? "",
                      about: aboutField.text ?? "",
                      jDate: joinDateField.text ?? "", salary: Int(salaryField.text ?? ""))
        if self.formType == .Update {
            self.presenter?.submitUpdateRecord(data: emp)
        } else {
            self.presenter?.submitNewRecord(data: emp)
        }
    }

    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
      // turn the fields to red
      for (field, error) in errors {
        if let field = field as? SkyFloatingLabelTextField {
            field.errorMessage = error.errorMessage
        }
      }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let activeTextfield = textField as? SkyFloatingLabelTextField
        activeTextfield?.errorMessage = ""
        activeTextfield?.errorColor = UIColor.black
       
        
        return true
    }

}


// MARK: - NewEmployeePresenterOutput

extension NewEmployeeVC: NewEmployeePresenterOutput {
    
    func updateQueryStatus(status: QueryStatus) {
        var messageText = ""
        switch status {
        case .insertSucess:
            messageText = "New Record created"
        case .insertFailure:
            messageText = "Fail to insert record"
        case .updateSucess:
            messageText = "Record is updated"
        case .updateFailure:
            messageText = "Record fail to update"
        }
        let alertVc = UIAlertController(title: "Query Status", message:messageText , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alertVc.addAction(okAction)
        self.present(alertVc, animated: true, completion: nil)
    }
    
}
