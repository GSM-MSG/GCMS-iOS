import RxSwift

public struct FetchMiniProfileUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private let userRepository: UserRepository

    public func execute() -> Single<MiniProfile> {
        userRepository.fetchMiniProfile()
    }
}
