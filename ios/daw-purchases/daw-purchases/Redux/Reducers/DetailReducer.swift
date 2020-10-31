//
//  DetailReducer.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift

func detailReducer(action: Action, state: DetailState?) -> DetailState {
    var state = state ?? DetailState()
    
    switch action {
    case let action as DetailAction:
        state.product = action.product
    default:
        break
    }
    
    return state
}
