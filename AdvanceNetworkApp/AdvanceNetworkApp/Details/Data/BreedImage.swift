//
//  BreedImage.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/19/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

struct BreedImage: Codable {
    let breeds : [Breed]?
    let id : String?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case breeds, id, url
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        breeds = try values.decodeIfPresent([Breed].self, forKey: .breeds)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
