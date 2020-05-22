//
//  LoaderTableViewCell.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/18/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class LoaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        loader.startAnimating()
    }
    
    func startAnimating() {
         loader.startAnimating()
    }

}
