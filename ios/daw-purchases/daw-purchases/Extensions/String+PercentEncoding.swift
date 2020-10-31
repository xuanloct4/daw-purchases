//
//  String+PercentEncoding.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import Foundation

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String {
    let unreserved = "-._~"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    
    if let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet) {
      return encodedString
    }
    
    return self
  }
}
