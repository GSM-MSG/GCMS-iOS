import RxSwift

public final class CheckIsVerifiedUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(email: String) -> Completable {
        authRepository.isVerified(email: email)
    }
}
