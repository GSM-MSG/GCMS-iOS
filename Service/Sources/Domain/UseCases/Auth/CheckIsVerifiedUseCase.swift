import RxSwift

public struct CheckIsVerifiedUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(email: String, code: String) -> Completable {
        authRepository.isVerified(email: email, code: code)
    }
}
