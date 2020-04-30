//
//  AddProfileViewController.swift
//  ProfileApp
//
//  Created by Balu Naik on 4/29/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

protocol AddProfileViewControllerDelegate: class {
    
    func saveNewprofile(data: Profile)
    
}

class AddProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var jobTextFiled: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    private var datePicker: UIDatePicker?
    private var selectedField: UITextField?
    weak var delegate: AddProfileViewControllerDelegate?
    
    let jobsList: [String] = ["Cricket Player", "Tennis player","Footballer player", "Basketball player", "Others"]
    let countryList = ["india", "Switzerland", "USA","Brazil","Germany", "Other"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pickerView.isHidden = true
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.profileImageView.backgroundColor = UIColor.lightGray
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
        submitButton.layer.cornerRadius = 4
        submitButton.setTitleColor(UIColor.white, for: .normal)
        self.setUpActionOnImageView()
    }
    
    func setUpActionOnImageView() {
        let gestureAction =  UITapGestureRecognizer(target: self, action: #selector(showImagePickerSource))
        gestureAction.numberOfTapsRequired = 2
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(gestureAction)
    }
    
    
    // MARK: - Private
    
    @objc private func showImagePickerSource() {
        let alertController = UIAlertController(title: "Source", message: "Select image source", preferredStyle: .actionSheet)
        let photoLibrary = UIAlertAction(title: "Library", style: .default) { (_) in
            //UIImagePickerController.SourceType.photoLibrary
            self.showImagePickerViewController(type: .photoLibrary)
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            //UIImagePickerController.SourceType.camera
             self.showImagePickerViewController(type: .camera)
        }
        let savedPhotosAlbum = UIAlertAction(title: "Photos Album", style: .default) { (_) in
            //UIImagePickerController.SourceType.savedPhotosAlbum
            self.showImagePickerViewController(type: .savedPhotosAlbum)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(photoLibrary)
        alertController.addAction(camera)
        alertController.addAction(savedPhotosAlbum)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showImagePickerViewController(type: UIImagePickerController.SourceType) {
        // What is UIImagePickerController?
        // This class object provides image/video gallery accesss from device
        let imagePickerView = UIImagePickerController()
        imagePickerView.sourceType = type
        imagePickerView.allowsEditing = true
        imagePickerView.delegate = self
        self.present(imagePickerView, animated: true, completion: nil)
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
    
    
    // MARK: - Actions
    
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
    
    @IBAction func submitClick(_ sender: Any) {
        if let name = self.fullNameTextField.text,
            let job = self.jobTextFiled.text,
            let dob = self.dobTextField.text,
            let country = self.countryTextField.text,
            let profileImage = self.profileImageView.image {
            ProfileDataAPI.saveImageInDocumentDir(image:profileImage , name: name.replacingOccurrences(of: " ", with: ""))
            let newProfile = Profile(name: name, jobTitle: job, country: country, dob: dob)
            self.delegate?.saveNewprofile(data: newProfile)
            // But the problem is image????
            
        }
    }
}

// MARK: - UITextFieldDelegate

extension AddProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedField = textField
        if textField == jobTextFiled || textField == countryTextField {
            //show picker for this fields
            textField.resignFirstResponder()
            textField.inputView = self.pickerView
           self.pickerView.reloadAllComponents()
           self.pickerView.isHidden = false
            
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


// MARK: - UIImagePickerControllerDelegate

extension AddProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User cancel loading image....")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


// MARK: - UIPickerViewDelegate
extension AddProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let field = self.selectedField else {
            
            return 0
        }
        
        return field == jobTextFiled ? self.jobsList.count : self.countryList.count
    }
    
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let field = self.selectedField else {
            
            return nil
        }
        
        //Rest of statement will be excutes if self.selectedField not nil
        
        return field == jobTextFiled ? self.jobsList[row] : self.countryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let field = self.selectedField else {
            
            return
        }
        if field == jobTextFiled {
            self.jobTextFiled.text = self.jobsList[row]
        } else {
            self.countryTextField.text = self.countryList[row]
        }
    }

}
