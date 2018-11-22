//
//  ApiManager.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import Foundation
import Alamofire
typealias DataCompletion = (Data?, Error?) -> Void

class ApiManager {

    var manager: SessionManager
    static let shared = ApiManager()

    private init() {
        let trustPolicies = MyServerTrustPolicyManager(policies: [:])
        manager = Alamofire.SessionManager(delegate: SessionDelegate(), serverTrustPolicyManager: trustPolicies)
    }

    func getAllVideo(params: [String: Any], completion: @escaping DataCompletion) {
        manager.request(Router.getAllVideo(params))
            .validate(statusCode: 200..<300)
            .responseData { response in
                completion(response.result.value, response.result.error)
        }
    }

    func searchMovie(params: [String: Any], completion: @escaping DataCompletion) {
        manager.request(Router.searchMovie(params))
            .validate(statusCode: 200..<300)
            .responseData { response in
                completion(response.result.value, response.result.error)
        }
    }
}

open class MyServerTrustPolicyManager: ServerTrustPolicyManager {

    // Override this function in order to trust any self-signed https
    open override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return ServerTrustPolicy.disableEvaluation

        // or, if `host` contains substring, return `disableEvaluation`
        // Ex: host contains `my_company.com`, then trust it.
    }
}
