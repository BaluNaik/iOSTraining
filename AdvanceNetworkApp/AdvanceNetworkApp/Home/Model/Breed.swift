//
//  Breed.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

struct Breed: Codable {
    
    let countryCode : String?
    let description : String?
    let id : String?
    let name : String?
    let origin : String?
    let wikipediaUrl: String?

    enum CodingKeys: String, CodingKey {

        case countryCode = "country_code"
        case description = "description"
        case id = "id"
        case name = "name"
        case origin = "origin"
        case wikipediaUrl = "wikipedia_url"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        wikipediaUrl = try values.decodeIfPresent(String.self, forKey: .wikipediaUrl)
    }
}
