//
//  Favourites.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/20/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation


struct Favourites: Codable {
    
    let createdAt : String?
    let id : Int?
    let imageId : String?
   

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case imageId = "image_id"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        imageId = try values.decodeIfPresent(String.self, forKey: .imageId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
}

