import RxSwift

public struct SendVerifyUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(email: String) -> Completable {
        authRepository.sendVerify(email: email)
    }
}
