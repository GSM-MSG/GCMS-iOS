import RxSwift

public struct CheckIsLoginedUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute() -> Completable {
        if UserDefaultsLocal.shared.isApple {
            return .create { comple in
                comple(.error(GCMSError.error(message: "It is apple", errorBody: ["Status": 401])))
                return Disposables.create()
            }
        }
        return authRepository.refresh()
    }
}
