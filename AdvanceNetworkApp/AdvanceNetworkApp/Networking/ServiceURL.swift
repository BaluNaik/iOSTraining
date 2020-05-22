//
//  ServiceURL.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class ServiceURL {
    
    static let apiKey = "b76dbef6-05f4-40ac-aef3-3511261eb946"
    
    static let baseUrl = "https://api.thecatapi.com/v1"
    static let breedsList = baseUrl + "/breeds"
    static let breedsSearch = baseUrl + "/breeds/search"
    static let breedsImageList = baseUrl + "/images/search"
    static let breedAddFavourites = baseUrl + "/favourites"
    static let favouritesList = baseUrl + "/favourites"
    static let deleteFavourites = baseUrl + "/favourites/{favourite_id}"
    static let favouritesImage = "https://cdn2.thecatapi.com/images/{image_id}"
    static let uploadUrl = baseUrl + "/images/upload"
    
}
