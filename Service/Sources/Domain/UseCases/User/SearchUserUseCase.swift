import RxSwift

public struct SearchUserUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private let userRepository: UserRepository

    public func execute(name: String, type: ClubType) -> Single<[User]> {
        userRepository.searchUser(name: name, type: type)
    }
}
