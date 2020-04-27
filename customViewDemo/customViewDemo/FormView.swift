//
//  FormView.swift
//  customViewDemo
//
//  Created by Balu Naik on 4/24/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

protocol FormViewDelegate: class {
    
    func submitData(data: [String: String])
    
}

class FormView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    weak var delegate: FormViewDelegate?
    @IBOutlet weak var firstNameLable: UILabel!
    @IBOutlet weak var lastNameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var dobLable: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    
    // MARK: - Action
    
    @IBAction func submitAction(_ sender: UIButton) {
        let info = ["fName": self.firstNameLable.text ?? "-",
                    "lName": self.lastNameLable.text ?? "-",
                    "email": self.emailLable.text ?? "-",
                    "dob": self.dobLable.text ?? "-"]
        self.delegate?.submitData(data: info)
    }
    
    
    // MARK: - Private
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FormView", owner: self, options: nil)  // it tells that xib belongs to current class
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.translatesAutoresizingMaskIntoConstraints = true
    }

}
