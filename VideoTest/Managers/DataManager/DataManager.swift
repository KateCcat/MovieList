//
//  DataManager.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    func getAllVideo(text: String, completion: @escaping ResultsCompletion) {
        
        let params: [String: String] = ["api_key": "eeba1ba6e47e416e9f4a16092139f64a", "language": "en-US", "sort_by": "popularity.desc", "include_adult" : "false", "include_video" : "false", "page" : "1"]
        ApiManager.shared.getAllVideo(params: params) { data, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data, let product: RootMovieInfo = try? JSONDecoder().decode(RootMovieInfo.self, from: data) {
                let result = product.results ?? []
                completion(result, nil)
                return
            }
        }
    }
}
