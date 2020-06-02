//
//  DetailViewController.swift
//  CoreDataApp
//
//  Created by Balu Naik on 6/2/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailLabel: UILabel!
    var detailItem: Commit?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let detail = self.detailItem {
            detailLabel.text = detail.message
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Commit 1/\(detailItem?.author?.commit?.count ?? 0)", style: .plain, target: self, action: #selector(showAuthorCommits))
        }
    }
    
    @objc func showAuthorCommits() {
        // this is your homework!
    }


}
