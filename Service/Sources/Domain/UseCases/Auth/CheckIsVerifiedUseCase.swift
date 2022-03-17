import RxSwift

public final class CheckIsVerifiedUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(email: String, isTest: Bool = false) -> Completable {
        authRepository.isVerified(email: email, isTest: isTest)
    }
}
