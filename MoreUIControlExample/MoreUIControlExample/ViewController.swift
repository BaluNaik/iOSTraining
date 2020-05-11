//
//  ViewController.swift
//  MoreUIControlExample
//
//  Created by Balu Naik on 5/11/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorSwift: UISwitch!
    @IBOutlet weak var progressBar: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if colorSwift.isOn {
            self.view.backgroundColor = colorSwift.thumbTintColor
        }
    }
    
    @IBAction func switchStatusChange(_ sender: UISwitch) {
        if colorSwift.isOn {
            self.view.backgroundColor = colorSwift.thumbTintColor
        } else {
            self.view.backgroundColor = colorSwift.tintColor
        }
        //self.view.backgroundColor = colorSwift.isOn ? colorSwift.thumbTintColor : colorSwift.tintColor
    }
    
    @IBAction func actiononSegmentChange(_ sender: UISegmentedControl) {
        var segmentTitle: String? = ""
        if sender.selectedSegmentIndex == 0 {
            segmentTitle = sender.titleForSegment(at: 0)
        } else if sender.selectedSegmentIndex == 1 {
            segmentTitle = sender.titleForSegment(at: 1)
        } else {
            segmentTitle = sender.titleForSegment(at: 2)
        }
        let alertController = UIAlertController(title: "Action", message: "Selected: \(segmentTitle ?? "")", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func stepperValueChanges(_ sender: UIStepper) {
        self.progressBar.progress = Float(sender.value)
    }
    
    @IBAction func sliderValueChanges(_ sender: UISlider) {
        self.progressBar.progress = Float(sender.value)
    }
    
}

