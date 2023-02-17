import RxSwift

public struct WithdrawalUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private let userRepository: UserRepository

    public func execute() -> Completable {
        userRepository.withdrawal()
    }
}
