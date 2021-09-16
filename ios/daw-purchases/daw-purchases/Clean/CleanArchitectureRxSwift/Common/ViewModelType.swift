//
//  ViewModelType.swift
//  daw-purchases
//
//  Created by Tran Loc on 14/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
