import RxSwift

public final class FetchUserInfoUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(isTest: Bool = false) -> Single<User> {
        repository.fetchUerInfo(isTest: isTest)
    }
}
