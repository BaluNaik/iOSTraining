//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Balu Naik on 5/5/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [String: [String]] = ["flowers":["Daffodil",
                                                     "Jasmine",
                                                     "Lily",
                                                     "Marigold",
                                                     "Primrose",
                                                     "Sweet violet",
                                                     "Saffron",
                                                     "Daisy",
                                                     "Lady of the Night",
                                                     "Lotus",
                                                     "Narcissus",
                                                     "Rose"],
                                          "animals":["bear",
                                                     "cat",
                                                     "dog",
                                                     "elephant",
                                                     "girraffe",
                                                     "horse",
                                                     "leopard",
                                                     "lion",
                                                     "monkey",
                                                     "zebra"],
                                          "fruits": ["apple",
                                                     "banana",
                                                     "dragonfruit",
                                                     "graps",
                                                     "mango",
                                                     "oranges",
                                                     "pomogranate",
                                                     "strwberry",
                                                     "turkey",
                                                     "watermelon"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.dataSource.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var keyValue = "flowers"  // section 1 is for flowers by default
        if section == 1 {
            keyValue = "animals"
            
        } else if section == 2 {
            keyValue = "fruits"
        }
        let list = self.dataSource[keyValue]
        
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCollectionViewCell {
            var keyValue = "flowers"  // section 1 is for flowers by default
            if indexPath.section == 1 {
                keyValue = "animals"
                
            } else if indexPath.section == 2 {
                keyValue = "fruits"
            }
            let dataList = self.dataSource[keyValue]
            if indexPath.item < dataList?.count ?? 0 {
                if let name = dataList?[indexPath.item] {
                    myCell.imageView.image = UIImage(named: name)
                    myCell.titleLabel.text = name
                }
            }
            cell = myCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: bounds.size.width / 3.0 - 12, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2.0
    }
    
}

