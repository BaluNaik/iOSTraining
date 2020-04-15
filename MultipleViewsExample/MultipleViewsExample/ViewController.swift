//
//  ViewController.swift
//  MultipleViewsExample
//
//  Created by Balu Naik on 4/14/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attributedStringWithColor()
    }
    
    // MARK: - Private method
    
    private func attributedStringWithColor() {
        let titleText = "First Screen"
        let attributedString = NSMutableAttributedString(string: titleText)
        let rangeOfFirst = (titleText as NSString).range(of: "First")
        //let rangeOfFirst = titleText.range(of: "First")
        //it returns Range type(Swift) but we need NSRange for NSMutableAttributedString
        
        let rangeOfScreen = (titleText as NSString).range(of: "Screen")
        
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.white,
                                        NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18.0)!], range: rangeOfFirst)
        
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green,
        NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 14.0)!], range: rangeOfScreen)
        
        self.titleLabel.attributedText = attributedString
    }
    
    
    
    
    // MARK: - Action
    
    @IBAction func loadNextView(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "SecondViewController") {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

