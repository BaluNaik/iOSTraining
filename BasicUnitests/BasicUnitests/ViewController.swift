//
//  ViewController.swift
//  BasicUnitests
//
//  Created by Balu Naik on 6/16/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkEvenNumber(_ number: Int) -> Bool {
        if number % 2 == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func sumOfNaturalNumbers(_ number: Int) -> Int {
        // number + (number - 1) + (number - 2)+.....1
        // if input is 5 ---> result (1+2+3+4+5) = 15
        var sum = 0;
        for i in 1 ... number {
            sum += i
        }
        
        return sum
    }
}

