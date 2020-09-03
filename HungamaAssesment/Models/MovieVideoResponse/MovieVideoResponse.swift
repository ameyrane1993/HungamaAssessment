//
//  MovieVideoResponse.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 03/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import Foundation

struct MovieVideoResponse : Codable {
    let id : Int?
    let movies : [Results]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case movies = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        movies = try values.decodeIfPresent([Results].self, forKey: .movies)
    }

}

