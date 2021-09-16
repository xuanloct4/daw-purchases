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

struct SearchState: StateType {
    var username: String?
    var productResults: Result<[Product], APIError>?
    var limit: Int?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(limit, forKey: .limit)
    }
    
    private enum CodingKeys: String, CodingKey {
        case username
        case limit
    }
}
