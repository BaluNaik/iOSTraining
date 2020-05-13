//
//  ViewController.swift
//  GcdSimpleApp
//
//  Created by Balu Naik on 5/13/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let startTime = CFAbsoluteTimeGetCurrent()
//        DispatchQueue.global(qos: .background).async {
//            for i in 1...10000 {
//                print("\(i)")
//            }
//        }
//        print("Mian Queue Blocked for:\(CFAbsoluteTimeGetCurrent() - startTime)")
//
        
        let queue1 = DispatchQueue(label: "com.company.app.queue")
        let group = DispatchGroup()
        group.enter()
        queue1.async {
            for i in 1...100 {
                print("\(i)")
            }
            group.leave()
        }
        group.enter()
        queue1.async {
            for i in 1...200 {
                print("\(i)")
            }
            group.leave()
        }
        group.wait()
        print("All task are finished")
        
    }
    
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("ohooo button event!!!")
        DispatchQueue.global(qos: .background).async {
            self.checkPrime()
        }
    }
    
    func checkPrime() {
        for i in 1...10000 {
            var flag = 0
            var k = 2
            while k < i {
                if i % k == 0 {
                    flag = 1
                    break
                }
                k = k + 1
            }
            if flag == 0 {
                DispatchQueue.main.async {
                    self.countLabel.text = "\(i)"
                }
            }
        }
    }

}

