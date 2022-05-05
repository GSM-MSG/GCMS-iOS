import RxSwift

public struct CheckIsLoginedUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute() -> Completable {
        if UserDefaultsLocal.shared.isApple {
            return .empty()
        }
        return authRepository.refresh()
    }
}
