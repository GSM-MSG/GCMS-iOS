import RxSwift

public final class SearchUserUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public let userRepository: UserRepository
    
    public func execute(query: ClubRequestQuery) -> Single<[User]> {
        userRepository.fetchSearchUser(query: query)
    }
}
