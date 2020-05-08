//
//  ProfileImageViewController.swift
//  UICollectionWithTableView
//
//  Created by Balu Naik on 5/7/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.imageView?.image = image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
    }

}
