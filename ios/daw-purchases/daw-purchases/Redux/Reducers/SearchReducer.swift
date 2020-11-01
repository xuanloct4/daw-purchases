//
//  SearchReducer.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift

func searchReducer(action: Action, state: SearchState?) -> SearchState {
    var state = state ?? SearchState()
    
    switch action {
    case let action as SearchUserPurchaseProductAction:
        state.username = action.username
        state.productResults = action.results
        break
    case _ as ResetSearchAction:
        state.username = nil
        state.productResults = nil
    default:
        break
    }
    
    return state
}
