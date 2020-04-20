//
//  EmpFormViewController.swift
//  FormApplicationWithProtocal
//
//  Created by Balu Naik on 4/20/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class EmpFormViewController: UIViewController {
    
    @IBOutlet weak var firstNameLable: BTLabel!
    @IBOutlet weak var lastNameLable: BTLabel!
    @IBOutlet weak var emailLable: BTLabel!
    @IBOutlet weak var genderLable: BTLabel!
    @IBOutlet weak var maleGenderLable: BTLabel!
    @IBOutlet weak var femaleGenderLable: BTLabel!
    @IBOutlet weak var dobLable: BTLabel!
    
    @IBOutlet weak var submitButton: BTButton!
    @IBOutlet weak var closeButton: BTButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    
    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: - Private Method
    
    private func setupUI() {
        firstNameLable.configureLabel()
        lastNameLable.configureLabel()
        emailLable.configureLabel()
        genderLable.configureLabel()
        maleGenderLable.configureLabel()
        femaleGenderLable.configureLabel()
        dobLable.configureLabel()
        maleButton.setImage(UIImage(named:"radiobutton_unchecked"), for: .normal)
        femaleButton.setImage(UIImage(named:"radiobutton_unchecked"), for: .normal)
        maleButton.setImage(UIImage(named:"radiobutton_checked"), for: .selected)
        femaleButton.setImage(UIImage(named:"radiobutton_checked"), for: .selected)
        maleButton.isSelected = true
        femaleButton.isSelected = false
        maleButton.isEnabled = true
        femaleButton.isEnabled = true
        closeButton.isEnabled = true
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonAction(_ sender: BTButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genderChangeAction(_ sender: UIButton) {
        maleButton.isSelected = !maleButton.isSelected
        femaleButton.isSelected = !femaleButton.isSelected
    }
    

}
