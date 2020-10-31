//
//  Redux.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import ReSwift

var store: Store<AppState> = Store<AppState>(reducer: appReducer, state: nil)
