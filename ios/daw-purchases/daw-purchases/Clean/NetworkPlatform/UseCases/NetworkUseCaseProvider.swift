import Foundation

public final class NetworkUseCaseProvider: UseCaseProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makePostsUseCase() -> PostsUseCase {
        return NetworkPostsUseCase(network: networkProvider.makePostsNetwork(),
                               cache: Cache<Post>(path: "allPosts"))
    }
}
