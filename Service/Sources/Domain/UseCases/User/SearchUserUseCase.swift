import RxSwift

public struct SearchUserUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    private let userRepository: UserRepository
    
    public func execute(query: ClubRequestQuery) -> Single<[User]> {
        userRepository.fetchSearchUser(query: query)
    }
}
