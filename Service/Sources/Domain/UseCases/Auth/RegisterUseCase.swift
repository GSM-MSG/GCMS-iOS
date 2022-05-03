import RxSwift

public struct RegisterUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(req: RegisterReqeust) -> Completable {
        authRepository.register(req: req)
    }
}
