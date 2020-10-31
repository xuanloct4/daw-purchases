//
//  AppReducer.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        searchState: searchReducer(action: action, state: state?.searchState),
        detailState: detailReducer(action: action, state: state?.detailState)
    )
}
