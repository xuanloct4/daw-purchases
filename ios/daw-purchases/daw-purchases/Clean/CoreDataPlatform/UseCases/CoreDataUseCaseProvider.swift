import Foundation

public final class CoreDataUseCaseProvider: UseCaseProvider {
    private let coreDataStack = CoreDataStack()
    private let postRepository: CoreDataRepository<Post>

    public init() {
        postRepository = CoreDataRepository<Post>(context: coreDataStack.context)
    }

    public func makePostsUseCase() -> PostsUseCase {
        return CoreDataPostsUseCase(repository: postRepository)
    }
}
