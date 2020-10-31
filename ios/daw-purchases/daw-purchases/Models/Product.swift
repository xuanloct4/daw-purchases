//
//  Product.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/30/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductInfo: Mappable, Codable {
    var id: Int!
    var face: String?
    var price: Double?
    var size: Int?
    var recent = [String]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        face <- map["face"]
        price <- map["price"]
        size <- map["size"]
    }
}


class Product: Mappable, Codable {
    var product: ProductInfo?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        product <- map["product"]
       
    }
}
