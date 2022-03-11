import RxSwift

public final class LoginUseCase {
    public init(authRepository: AuthRepository) {
        self.repository = authRepository
    }
    
    private let repository: AuthRepository
    
    public func execute(idToken: String, isTest: Bool = false) -> Completable {
        return repository.login(idToken: idToken, isTest: isTest)
    }
}
