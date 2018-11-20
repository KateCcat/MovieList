//
//  RootMovieInfo.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import Foundation

struct RootMovieInfo: Codable {

    let page: Int?
    let results: [MovieInfo]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([MovieInfo].self, forKey: .results)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}
