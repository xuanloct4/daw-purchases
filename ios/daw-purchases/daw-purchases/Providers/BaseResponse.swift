//
//  BaseResponse.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/31/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import ObjectMapper

public class BaseResponse<T>: Mappable where T: Mappable {
    public var data: T?
    public var dataArray: [T]?
    
    required public init?(map: Map) {
      }
      
    public func mapping(map: Map) {
        data <- map["data"]
        dataArray <- map["data"]
    }
}
