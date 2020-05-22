//
//  FavouritesTableViewCell.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/20/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import SDWebImage

class FavouritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var createdDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favImageView.layer.cornerRadius = favImageView.frame.height / 2.0
        favImageView.layer.borderWidth = 1
        favImageView.layer.borderColor = UIColor.blue.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favImageView.image = nil
        createdDateLabel.text = ""
    }
    
    func configCell(_ imageId: String, createdAt: String) {
        let urlString = ServiceURL.favouritesImage.replacingOccurrences(of: "{image_id}", with: imageId) + ".jpg"
        if let url = URL(string: urlString) {
            //self.favImageView.sd_setImage(with: url, completed: nil)
            NetworkWrapper.sharedInstance.imageDownloadRequest(endPoint: url, sucess: {[weak self] (data) in
                if let imageData = data {
                    DispatchQueue.main.async {
                        self?.favImageView.image = UIImage(data: imageData)
                    }
                }

            }){ (_) in }
        }
        //TODO: Convert string into Date format of DD MMM YYYY
        self.createdDateLabel.text = createdAt
    }
}
