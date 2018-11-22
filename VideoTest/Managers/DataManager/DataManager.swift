//
//  DataManager.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import Foundation
typealias ResultsCompletion = (RootMovieInfo?, Error?) -> Void

class DataManager {

    static let shared = DataManager()

    private init() {}

    func getAllVideo(page: String, completion: @escaping ResultsCompletion) {

        let params: [String: String] = ["api_key": "eeba1ba6e47e416e9f4a16092139f64a", "language": "en-US", "sort_by": "popularity.desc", "include_adult": "false", "include_video": "false", "page": "\(page)"]
        ApiManager.shared.getAllVideo(params: params) { data, error in

            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data, let product: RootMovieInfo = try? JSONDecoder().decode(RootMovieInfo.self, from: data) {
                let result = product
                completion(result, nil)
                return
            }
        }
    }

    func searchMovie(page: String, query: String, completion: @escaping ResultsCompletion) {

        let params: [String: String] = ["api_key": "eeba1ba6e47e416e9f4a16092139f64a", "language": "en-US", "include_adult": "false", "query": "\(query)", "page": "\(page)"]
        ApiManager.shared.searchMovie(params: params) { data, error in

            if let error = error {
                completion(nil, error)
                return
            }
            if let data = data, let product: RootMovieInfo = try? JSONDecoder().decode(RootMovieInfo.self, from: data) {
                let result = product
                completion(result, nil)
                return
            }
        }
    }
}
