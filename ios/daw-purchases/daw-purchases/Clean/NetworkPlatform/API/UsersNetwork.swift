//
//  UsersNetwork.swift
//  CleanArchitectureRxSwift
//
//  Created by Andrey Yastrebov on 16.03.17.
//  Copyright © 2017 sergdort. All rights reserved.
//

import RxSwift

public final class UsersNetwork {
    private let network: Network<Users>

    init(network: Network<Users>) {
        self.network = network
    }

    public func fetchUsers() -> Observable<[Users]> {
        return network.getItems("users")
    }

    public func fetchUser(userId: String) -> Observable<Users> {
        return network.getItem("users", itemId: userId)
    }
}
