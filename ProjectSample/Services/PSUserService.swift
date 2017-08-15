//
//  PSUserService.swift
//  ProjectSample
//
//  Created by Narlei A Moreira on 14/08/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import Moya

let PSUserProvider = MoyaProvider<PSUserService>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum PSUserService {
    case search(query: String)
    case repositories(userId:String)
}

extension PSUserService: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .search:
            return "/search/users"
        case .repositories(let userId):
            return "/users/\(userId)/repos"
        }
    }
    var method: Moya.Method {
        switch self {
        case .search, .repositories:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .search(let query):
            return ["q": query]
        default:
            return nil
        }
    }
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .search, .repositories:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    var task: Task {
        switch self {
        case .search, .repositories:
            return .request
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
