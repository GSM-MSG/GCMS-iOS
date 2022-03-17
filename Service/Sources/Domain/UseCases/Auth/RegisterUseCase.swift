import RxSwift

public final class RegisterUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(req: RegisterReqeust, isTest: Bool = false) -> Completable {
        authRepository.register(req: req, isTest: isTest)
    }
}
