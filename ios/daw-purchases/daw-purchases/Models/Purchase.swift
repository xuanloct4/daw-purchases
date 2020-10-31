//
//  Purchase.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/30/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import ObjectMapper

class Purchase: Mappable, Codable {
    var id: Int!
    var productId: Int!
    var username: String!
    var date: Date!
    
    var readableCreatedAt: String {
        return DateUtils.dateString(date: date, dateFormat: DateUtils.dateFormatter)
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        productId <- map["productId"]
        username <- map["username"]
        if let dateString = map["date"].currentValue as? String, let _date = DateUtils.dateFrom(string:dateString) {
            date = _date
        }
    }
}


class Purchases: Mappable, Codable {
    var purchases: [Purchase]!
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        purchases <- map["purchases"]
    }
}
