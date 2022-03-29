import RxSwift

public final class LoginUseCase {
    public init(authRepository: AuthRepository) {
        self.repository = authRepository
    }
    
    private let repository: AuthRepository
    
    public func execute(req: LoginRequest) -> Completable {
        repository.login(req: req)
    }
}
