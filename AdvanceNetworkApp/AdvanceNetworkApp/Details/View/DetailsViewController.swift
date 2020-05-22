//
//  DetailsViewController.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/19/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit


class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataProvider = DetailsDataProvider()
    var breed: Breed?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainLoader()
        dataProvider.delegate = self
        if let breedID = breed?.id {
            self.dataProvider.getImagesList(for: breedID)
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let breedName = breed?.name {
            self.titleLabel.text = breedName
        }
        if let origin = breed?.origin {
            self.originLabel.text = origin
        }
        self.title = "Details"
    }
    
    
    // MARK: - Action
    
    @IBAction func actionOnMoreInformation(_ sender: UIButton) {
        if let urlString = breed?.wikipediaUrl,
        let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - DetailsDataProviderDelegate

extension DetailsViewController: DetailsDataProviderDelegate {
    
    func updateContent() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showLoader(_ show: Bool) {
        self.showLoaderOnView(show)
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.showErrorAlert(message)
        }
    }
}

extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataProvider.getImageCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedImageCell", for: indexPath) as? BreedImageCell {
            if indexPath.item < self.dataProvider.getImageCount() {
                let imageInformation = self.dataProvider.getImageInformation(for: indexPath.item)
                myCell.setImageView(imageInformation)
            }
            myCell.delegate = self
            
            cell = myCell
        }
        
        return cell
    }
    
}


// MARK: - BreedImageCellDelegate

extension DetailsViewController: BreedImageCellDelegate {
    
    func addTofavourites(with imageKeyID: String) {
        self.dataProvider.addfavourites(for: imageKeyID)
    }
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: self.view.frame.width - 12, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
}
