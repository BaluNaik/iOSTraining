//
//  FavouritesDataProvider.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/20/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class FavouritesDataProvider: NSObject {
    
    var favourites:[Favourites] = []
    weak var delegate: FavouritesDataProviderProtocal?
    
    var favouritesCount: Int {
        
        return self.favourites.count
    }
    
    // MARK: - API Helper
    
    func getFavouritesList() {
        self.delegate?.showLoader(true)
        NetworkWrapper.sharedInstance.getRequest(endPoint: ServiceURL.favouritesList, parameters: [:], sucess: {[weak self] (response) in
            if let data = response {
               let jsonDecoder = JSONDecoder()
                let responseModelList = try? jsonDecoder.decode([Favourites].self, from: data)
                if let list = responseModelList {
                    self?.favourites = list
                }
            }
            self?.delegate?.updateContent()
            self?.delegate?.showLoader(false)
        }) {[weak self] (error) in
            if let err = error {
                self?.delegate?.showError(err.localizedDescription)
            }
            self?.delegate?.showLoader(false)
        }
    }
    
    func deleteFavourite(favouriteId: Int, sucess: @escaping() -> Void,
                         fail: @escaping(_ error: Error?) -> Void) {
        self.delegate?.showLoader(true)
        NetworkWrapper.sharedInstance.deleteRequest(endPoint: ServiceURL.deleteFavourites.replacingOccurrences(of: "{favourite_id}", with: "\(favouriteId)"), parameters: [:], sucess: { (_) in
            sucess()
        }) { (error) in
            fail(error)
        }
    }
    
    
    // MARK: - Public
    
    func getfavouritesInformation(for index: Int) -> Favourites {
        
        return self.favourites[index]
    }
    
    func deleteFavouriteObject(for index: Int) {
        self.favourites.remove(at: index)
    }
    
}
