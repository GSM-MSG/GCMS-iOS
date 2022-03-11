import RxSwift

public final class SearchUserUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(query: String, isTest: Bool = false) -> Single<[User]> {
        repository.searchUser(query: query, isTest: isTest)
    }
}
