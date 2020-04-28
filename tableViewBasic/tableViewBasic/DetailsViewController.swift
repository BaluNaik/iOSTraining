//
//  DetailsViewController.swift
//  tableViewBasic
//
//  Created by Balu Naik on 4/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    private var pageTitle: String?
    private var imageName: String?
    
    func setData(title: String, imageName: String) {
        self.pageTitle = title
        self.imageName = imageName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.pageTitle
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let imagename = imageName {
            self.imageView.image = UIImage(named: imagename)
        }
    }

}
