import RxSwift

public final class FetchProfileUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    private let userRepository: UserRepository
    
    public func execute() -> Single<UserProfile> {
        userRepository.fetchMyProfile()
    }
}
