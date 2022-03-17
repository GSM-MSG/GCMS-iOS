import RxSwift

public final class CheckIsLoginedUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute(isTest: Bool = false) -> Completable {
        authRepository.refresh(isTest: isTest)
    }
}
