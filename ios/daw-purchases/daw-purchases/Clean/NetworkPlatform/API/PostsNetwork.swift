//
//  PostsNetwork.swift
//  CleanArchitectureRxSwift
//
//  Created by Andrey Yastrebov on 10.03.17.
//  Copyright © 2017 sergdort. All rights reserved.
//

import RxSwift

public final class PostsNetwork<T> where T: Codable & JsonSerializable {
    private let network: Network<T>

    init(network: Network<T>) {
        self.network = network
    }

    public func fetchPosts() -> Observable<[T]> {
        return network.getItems("posts")
    }

    public func fetchPost(postId: String) -> Observable<T> {
        return network.getItem("posts", itemId: postId)
    }

    public func createPost(post: T) -> Observable<T> {
        return network.postItem("posts", parameters: post.toJSON())
    }

    public func deletePost(postId: String) -> Observable<T> {
        return network.deleteItem("posts", itemId: postId)
    }
}
