//
//  TweetDetailReducer.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 1.04.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift

func tweetDetailReducer(action: Action, state: DetailState?) -> DetailState {
  var state = state ?? DetailState()
  
  switch action {
  case let action as DetailAction:
    state.user = action.user
  default:
    break
  }
  
  return state
}
