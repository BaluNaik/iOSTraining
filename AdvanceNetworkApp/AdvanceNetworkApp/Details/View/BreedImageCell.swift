//
//  BreedImageCell.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/19/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import SDWebImage

protocol BreedImageCellDelegate: class {
    func addTofavourites(with imageKeyID: String)
}

class BreedImageCell: UICollectionViewCell {
    
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    private var breedImageInfo: BreedImage?
    weak var delegate: BreedImageCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.favButton.isSelected = false
    }
    
    
    func setImageView(_ imageInformation: BreedImage) {
        self.breedImageInfo = imageInformation
        if let urlString = self.breedImageInfo?.url,
            let url = URL(string: urlString) {
            breedImage.sd_setImage(with: url, completed: nil)
//            print("\(url.absoluteURL)")
//            NetworkWrapper.sharedInstance.imageDownloadRequest(endPoint: url, sucess: {[weak self] (data) in
//                if let imageData = data {
//                    DispatchQueue.main.async {
//                        self?.breedImage.image = UIImage(data: imageData)
//                    }
//                }
//
//            }){ (_) in }
        }
    }
    
    @IBAction func FavButtonChange(_ sender: UIButton) {
        self.favButton.isSelected = true
        if let imageKey = self.breedImageInfo?.id {
             self.delegate?.addTofavourites(with: imageKey )
        }
    }
    
}
