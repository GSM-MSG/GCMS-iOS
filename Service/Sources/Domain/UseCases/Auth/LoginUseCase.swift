import RxSwift

public final class LoginUseCase {
    public init(repository: AuthRepository) {
        self.repository = repository
    }
    
    private let repository: AuthRepository
    
    public func execute(idToken: String, isTest: Bool = false) -> Completable {
        repository.login(idToken: idToken, isTest: isTest)
    }
}
