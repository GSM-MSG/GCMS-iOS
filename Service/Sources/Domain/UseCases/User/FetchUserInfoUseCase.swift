import RxSwift

public final class FetchUserInfoUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    public func execute(isTest: Bool = false) -> Single<User> {
        repository.fetchUerInfo(isTest: isTest)
    }
}
