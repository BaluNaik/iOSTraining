//
//  SecondViewController.swift
//  MultipleViewsExample
//
//  Created by Balu Naik on 4/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("loadview")
        self.configUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//          print("viewDidLayoutSubviews")
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print("viewWillLayoutSubviews")
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("deinit")
    }
    
    /*  == View Life Cycle ====
       1.  loadview (call once)
       2.  viewDidLoad (once)
       3.  viewWillAppear
       4.  viewDidAppear
       5.  viewWillDisappear
       6.  viewDidDisappear
       7.  deinit
     */
    
    // MARK: - Private
    
    func configUI() {
        // First setup Label
        let titleLabel = UILabel(frame: CGRect(x: 30.0, y: 40.0, width: 200.0, height: 40.0))
        titleLabel.text = "Second Screen"
        titleLabel.backgroundColor = UIColor.orange
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.borderColor = UIColor.red.cgColor
        titleLabel.layer.borderWidth = 4.0
        titleLabel.layer.cornerRadius = 3.0
        titleLabel.layer.masksToBounds = true
        self.view.addSubview(titleLabel)
        
        // Setup ImageView
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 150, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 50), size: CGSize(width: 300, height: 200)))
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.layer.cornerRadius = 3.0
        imageView.image = UIImage(named: "rose")
        self.view.addSubview(imageView)
        
        // Setup buttons
        let previousButton = UIButton(type: .custom)
        previousButton.frame = CGRect(x: 30, y: self.view.frame.size.height / 2 - 50, width: 100, height: 44)
        previousButton.setImage(UIImage(named: "previous"), for: .normal)
        previousButton.tag = 101
        self.view.addSubview(previousButton)
        
        
        let nextButton = UIButton(type: .custom)
        nextButton.frame = CGRect(x: self.view.frame.size.width - 130, y: self.view.frame.size.height / 2 - 50, width: 100, height: 44)
        nextButton.setImage(UIImage(named: "next"), for: .normal)
        nextButton.tag = 102
        self.view.addSubview(nextButton)
        
        // Setup button actions
        previousButton.addTarget(self, action: #selector(actionOnButtonClick(sender:)), for: .touchUpInside)
        //addTarget is obj-c method so its required to expose our swift method to obj-c by adding @objc
        nextButton.addTarget(self, action: #selector(actionOnButtonClick(sender:)), for: .touchUpInside)
    }
    
    
    
    // MARK: - Actions
    
    @objc fileprivate func actionOnButtonClick( sender: UIButton) {
        if sender.tag == 101 { // previousButton
            self.dismiss(animated: true, completion: nil)
        } else {
            //Load next screen
//            if let vcList = Bundle.main.loadNibNamed("ThirdViewController", owner: self, options: nil),
//                let vc = vcList[0] as? SecondViewController {
//                self.present(vc, animated: true, completion: nil)
//            }
            let vc = ThirdViewController(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    
        }
    }
}
