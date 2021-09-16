import Foundation
import Realm
import RealmSwift

public final class RealmUseCaseProvider: UseCaseProvider {
    private let configuration: Realm.Configuration

    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }

    public func makePostsUseCase() -> PostsUseCase {
        let repository = Repository<Post>(configuration: configuration)
        return RealmPostsUseCase(repository: repository)
    }
}
