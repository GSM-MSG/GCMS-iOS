import RxSwift

public final class FetchProfileUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public let userRepository: UserRepository
    
    public func execute() -> Single<UserProfile> {
        userRepository.fetchProfile()
    }
}
