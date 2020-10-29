//
//  OAuthTwitterHeader
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation
import CryptoSwift

class OAuthTwitterHeader {
  private var httpMethod: String
  private var url: String
  private var requestParameters: [String: Any]
  private var oAuthParameters: [String: Any] = [:]
  
  init(method: String, url: String, requestParameters: [String: Any]) {
    self.httpMethod = method
    self.url = url
    self.requestParameters = requestParameters
   
  }
    
    func getData() -> String {
      var data: String = "OAuth "
      
      let lastParameterOffset = oAuthParameters.count - 1
      for (offset: i, element: (key: key, value: value)) in oAuthParameters.enumerated() {
        if i != lastParameterOffset {
          data += "\(key)=\"\(value)\", "
        } else {
          data += "\(key)=\"\(value)\""
        }
      }
      
      return data
    }
}
