//
//  Router.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    case getAllVideo([String: Any])
    case searchMovie([String: Any])

    #if DEBUG
    static let baseURL = "https://api.themoviedb.org/3"
    #else
    static let baseURL = "https://api.themoviedb.org/3"
    #endif

    private var urlEncoder: ParameterEncoding {
        return Alamofire.URLEncoding()
    }
    private var jsonEncoder: ParameterEncoding {
        return Alamofire.JSONEncoding()
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAllVideo:
            return .get
        case .searchMovie:
            return .get
        }
    }

    var path: String {
        switch self {

        case .getAllVideo:
            return "/discover/movie/"
        case .searchMovie:
            return "/search/movie/"
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    func asURLRequest() throws -> URLRequest {

        let requestUrl = URL(string: Router.baseURL + path)
        var request = try URLRequest(url: requestUrl!, method: method)
        switch self {
        case .getAllVideo(let params):
            request = try urlEncoder.encode(request, with: params)
        case .searchMovie(let params):
            request = try urlEncoder.encode(request, with: params)
        }
        return request
    }
}
