//
//  SearchState.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import Result
import ReSwift
import RxSwift
import Moya

struct SearchState: StateType, Encodable {
    static var moyaProvider: MoyaProvider<DAWProvider> = MoyaProvider<DAWProvider>(manager: DefaultAlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin(verbose: true)])
    static var disposeBag = DisposeBag()
    var username: String?
    var purchaseResults: Result<[Purchase], APIError>?
    var productResults: Result<[Product], APIError>?
    var limit: Int?
    var productResult: Result<Product?, APIError>?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(limit, forKey: .limit)
    }
    
    private enum CodingKeys: String, CodingKey {
        case username
        case results
        case limit
    }
}
