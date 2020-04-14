//
//  ViewController.swift
//  BackgroundChange
//
//  Created by Balu Naik on 4/14/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundColorLabel: UILabel!
    @IBOutlet weak var nextColorButton: UIButton!
    
    let colors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.orange, UIColor.yellow]
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpIntialState()
    }
    
    
    //MARK: - Private methods
    
    private func setUpIntialState() {
        //self.view.backgroundColor = colors[0] // No its not safe todo??? if array is empty it will crash
        if let defaultColor = self.colors.first {
            self.view.backgroundColor = defaultColor
        }
        //Set labale
        //self.backgroundColorLabel.text = "Red"
        self.backgroundColorLabel.text = self.getColorName(color: self.view.backgroundColor)
        self.backgroundColorLabel.backgroundColor = UIColor.white
        //self.backgroundColorLabel.textAlignment = NSTextAlignment.center
        self.backgroundColorLabel.textAlignment = .center
        
        //Set button
        let count = self.colors.count
        if count > 0 {
            self.nextColorButton.backgroundColor = self.colors[1]
            //self.nextColorButton.setTitle("Blue", for: .normal)
            self.nextColorButton.setTitle(self.getColorName(color: self.nextColorButton.backgroundColor), for: .normal)
            self.nextColorButton.layer.borderWidth = 1.0
            self.nextColorButton.layer.cornerRadius = 1.0
            self.nextColorButton.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func changeBackground(index: Int) {
        // first set proper index value if its out of range
        let selectedIndex: Int = (index >= self.colors.count - 1) ? 0 : index + 1
       
        self.view.backgroundColor = self.colors[selectedIndex]
        self.backgroundColorLabel.text = self.getColorName(color: self.view.backgroundColor)
        
        self.nextColorButton.backgroundColor = self.colors[selectedIndex == self.colors.count - 1 ? 0 : selectedIndex + 1]
        self.nextColorButton.setTitle(self.getColorName(color: self.nextColorButton.backgroundColor), for: .normal)
        currentIndex = selectedIndex
    }
    
    private func getColorName(color: UIColor?) -> String {
        if let selectedColor = color {
            switch selectedColor {
            case .red:
                
                return "Red"
            case .blue:
                
                return "Blue"
            case .orange:
                
                return "Orange"
            default:
                
                return "Yello"
            }
        }
        
        return ""
    }
    
    
    // MARK: - Action
    
    @IBAction func actionOnButtonClick(_ sender: Any) {
        self.changeBackground(index: self.currentIndex)
    }
    

}

