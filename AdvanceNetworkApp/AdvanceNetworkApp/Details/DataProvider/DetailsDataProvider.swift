//
//  DetailsDataProvider.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/19/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

protocol DetailsDataProviderDelegate: class {
    
    func updateContent()
    func showLoader(_ show: Bool)
    func showError(_ message: String)
    
}


class DetailsDataProvider: NSObject {
    
    var images:[BreedImage] = []
    private var limit = 5
    weak var delegate: DetailsDataProviderDelegate?
    
    
    // MARK: - API Helper
    
    func getImagesList( for breedID: String) {
        self.delegate?.showLoader(true)
        let params:[String: Any] = ["breed_id": breedID,
                                    "limit": self.limit,
                                    "order" : "DESC",
                                    "size": "med"]
        NetworkWrapper.sharedInstance.getRequest(endPoint: ServiceURL.breedsImageList, parameters: params, sucess: {[weak self] (response) in
            if let data = response {
               let jsonDecoder = JSONDecoder()
                let responseModelList = try? jsonDecoder.decode([BreedImage].self, from: data)
                if let list = responseModelList,
                    list.count > 0 {
                    self?.updateImageList(list: list)
                }
            }
            self?.delegate?.showLoader(false)
        }) {[weak self] (error) in
            if let err = error {
                self?.delegate?.showError(err.localizedDescription)
            }
            self?.delegate?.showLoader(false)
        }
    }
    
    func addfavourites(for imageID: String) {
        self.delegate?.showLoader(true)
        let params:[String: String] = ["image_id": imageID]
        NetworkWrapper.sharedInstance.postRequest(endPoint: ServiceURL.breedAddFavourites, parameters: params, sucess: {[weak self] (response) in
            if let data = response {
                do {
                    let jsonRespone = try JSONSerialization.jsonObject(with: data, options:[]) // Data ---> Json
                    if let responseDictionary = jsonRespone as? [String: Any] {
                        self?.delegate?.showError(responseDictionary["message"] as? String ?? "")
                    }
                } catch {
                    print("JSON Error: json parsing error")
                }
            }
            self?.delegate?.showLoader(false)
        }) {[weak self] (error) in
            if let err = error {
                self?.delegate?.showError(err.localizedDescription)
            }
            self?.delegate?.showLoader(false)
        }
    }
    
    
    
    // MARK: - Public Methods
    
    func getImageCount() -> Int {
        
        return self.images.count
    }
    
    func getImageInformation(for index: Int) -> BreedImage {
        
        return self.images[index]
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func updateImageList( list: [BreedImage]) {
        self.images = list
        self.delegate?.updateContent()
    }
 
}
