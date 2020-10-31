//
//  SearchReducer.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift
import Result

func searchReducer(action: Action, state: SearchState?) -> SearchState {
  var state = state ?? SearchState()
  
  switch action {
//  case let action as SearchUsersAction:
////    state.results = action.results
//    state.limit = action.limit
//    state.username = action.username
//  case let action as LoadMorePurchasesAction:
//    state.limit = action.limit
//
//    switch action.results {
//    case let .success(tweets):
//      if var currentTweets = state.results!.value {
//        currentTweets.append(contentsOf: tweets)
//
//        state.results = .success(currentTweets)
//      }
//      break
//    case .failure(_):
//      state.results = action.results
//      break
//    }
//    break
    
    case let action as SearchPurchasesByUserAction:
    state.username = action.username
    state.purchaseResults = action.results
    break
  case let action as SearchUserPurchaseProductAction:
    state.username = action.username
    state.productResults = action.results
    break
    
   
    
  case let action as GetProductInfoAction:
    state.productResult = action.results
    break
  case _ as ResetSearchAction:
    state.username = nil
    state.productResults = nil
    state.limit = nil
  default:
    break
  }
  
  return state
}
