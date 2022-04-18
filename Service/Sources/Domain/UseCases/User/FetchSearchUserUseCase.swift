import RxSwift

public final class FetchSearchUserUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public let userRepository: UserRepository
    
    public func execute(query: ClubRequestQuery) -> Single<[User]> {
        userRepository.fetchSearchUser(query: query)
    }
}
