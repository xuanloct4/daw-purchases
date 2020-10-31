//
//  AppState.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType {
  var navigationState: NavigationState
  var searchState: SearchState = SearchState()
  var detailState: DetailState = DetailState()
}
