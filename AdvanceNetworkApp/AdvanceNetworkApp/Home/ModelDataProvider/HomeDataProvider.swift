//
//  HomeDataProvider.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class HomeDataProvider: NSObject {
    
    var breeds:[Breed] = []
    private var pageLimit = 15
    weak var delegate:HomeDataProviderProtocal?
    
    // MARK: - API Helper
    
    func getBreedList(for page: Int) {
        self.delegate?.showLoader(true)
        let params:[String: Any] = ["page": page,
                                    "limit": self.pageLimit]
        NetworkWrapper.sharedInstance.getRequest(endPoint: ServiceURL.breedsList, parameters: params, sucess: {[weak self] (response) in
            if let data = response {
               let jsonDecoder = JSONDecoder()
                let responseModelList = try? jsonDecoder.decode([Breed].self, from: data)
                if let list = responseModelList,
                    list.count > 0 {
                    self?.updatebreedList(list: list)
                } else {
                    self?.delegate?.stopLoadingNextPage()
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
    
    func searchBreeds(for type: String) {
        breeds = []
        self.delegate?.showLoader(true)
        let params:[String: String] = ["q": type]
        NetworkWrapper.sharedInstance.getRequest(endPoint: ServiceURL.breedsSearch, parameters: params, sucess: {[weak self] (response) in
            if let data = response {
                let jsonDecoder = JSONDecoder()
                let responseModelList = try? jsonDecoder.decode([Breed].self, from: data)
                if let list = responseModelList {
                    self?.breeds = list
                    self?.delegate?.updateContent()
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
    
    func getBreddCount() -> Int {
        
        return self.breeds.count
    }
    
    func getBreedInformation(for index: Int) -> Breed {
        
        return self.breeds[index]
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func updatebreedList( list: [Breed]) {
        if self.breeds.count == 0 {
            self.breeds = list
        } else {
            self.breeds.append(contentsOf: list)
        }
        self.delegate?.updateContent()
    }
 
}
