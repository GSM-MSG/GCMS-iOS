import RxSwift

public final class FetchUserInfoUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    func execute(isTest: Bool = false) -> Single<User> {
        return repository.fetchUerInfo(isTest: isTest)
    }
}
