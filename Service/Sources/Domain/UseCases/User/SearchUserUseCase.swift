import RxSwift

public final class SearchUserUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    public func execute(query: String, isTest: Bool = false) -> Single<[User]> {
        repository.searchUser(query: query, isTest: isTest)
    }
}
