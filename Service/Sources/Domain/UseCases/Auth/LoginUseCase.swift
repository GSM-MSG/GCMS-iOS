import RxSwift

public final class LoginUseCase {
    public init(authRepository: AuthRepository) {
        self.repository = authRepository
    }
    
    private let repository: AuthRepository
    
    public func execute(req: LoginRequest, isTest: Bool = false) -> Completable {
        repository.login(req: req, isTest: isTest)
    }
}
