//
//  User.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable, Codable {
  var username: String!
  var email: String!
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    username <- map["username"]
    email <- map["email"]
  }
}
