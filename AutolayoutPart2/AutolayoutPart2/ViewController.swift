//
//  ViewController.swift
//  AutolayoutPart2
//
//  Created by Balu Naik on 4/23/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fbIcon: UIImageView!
    @IBOutlet weak var twiIcon: UIImageView!
    @IBOutlet weak var whatsappIcon: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.stackView.isHidden = true
        //self.stackView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //showHideStackViewWithAnimation()
    }

    @IBAction func changeLayout(_ sender: Any) {
        if imageViewWConstraint.constant <= 200 {
            imageViewWConstraint.constant = imageViewWConstraint.constant + 10.0
        }
        if viewTopConstraint.constant <= 80 {
            viewTopConstraint.constant = viewTopConstraint.constant + 10
        }
    }
    
    @IBAction func dropFacbookIcon(_ sender: UIButton) {
        //self.fbIcon.isHidden = !self.fbIcon.isHidden
        showHideStackViewWithAnimation()
    }
    
    fileprivate func showHideStackViewWithAnimation() {
//        UIView.animate(withDuration: 3) {
//            self.stackView.alpha = self.stackView.alpha == 0 ? 1 : 0
//        }
        var viewFrame = stackView.frame
        if self.stackView.isHidden {
            viewFrame.origin.x = -170.0
            stackView.frame.origin.x =  viewFrame.origin.x
            self.stackView.isHidden = false
            UIView.animate(withDuration: 1) {
                self.stackView.frame.origin.x = 20.0
            }
        } else {
            self.stackView.frame.origin.x = 20.0
            UIView.animate(withDuration: 1, animations: {
                self.stackView.frame.origin.x = -170.0
            }) { (_) in
                self.stackView.isHidden = true
            }
        }
    }
    
}

