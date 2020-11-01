//
//  DAWProvider.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import Moya

enum DAWProvider {
    case getPurchasesByUser(username: String, limit: Int?)
    case getPurchasesByProductId(productId: Int, limit: Int?)
    case getProductById(productId: Int)
    case getUsers(limit: Int?)
    case getUsersByUsername(username: String)
}

extension DAWProvider : TargetType {
    var baseURL: URL { return URL(string: "http://localhost:8000/api")! }
    
    var path: String {
        switch self {
        case .getPurchasesByUser(let username, _):
            return "/purchases/by_user/\(username)"
        case .getPurchasesByProductId(let productId, _):
            return "/purchases/by_product/\(productId)"
        case .getProductById(let productId):
            return "/products/\(productId)"
        case .getUsers( _):
            return "/users"
        case .getUsersByUsername(let username):
            return "/users/\(username)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data { return Data() }
    
    var task: Task {
        switch self {
        case .getPurchasesByUser( _, let limit):
            let parameters: [String: Any] = ["limit": limit as Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getPurchasesByProductId( _, let limit):
            let parameters: [String: Any] = ["limit": limit as Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getProductById( _):
            return .requestPlain
        case .getUsers(let limit):
            let parameters: [String: Any] = ["limit": limit as Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getUsersByUsername( _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .none
    }
}

