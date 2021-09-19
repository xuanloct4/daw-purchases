//
//  NetworkRepresentable.swift
//  daw-purchases
//
//  Created by Tran Loc on 17/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

protocol NetworkRepresentable {
    associatedtype NetworkType: DomainConvertibleType

    var uid: String {get}

    func asNetwork() -> NetworkType
}
