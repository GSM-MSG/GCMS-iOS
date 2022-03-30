import RxSwift

public final class SendVerifyUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(email: String, code: String) -> Completable {
        authRepository.sendVerify(email: email, code: code)
    }
}
