import RxSwift

public final class SendVerifyUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(email: String, isTest: Bool = false) -> Completable {
        authRepository.sendVerify(email: email, isTest: isTest)
    }
}
