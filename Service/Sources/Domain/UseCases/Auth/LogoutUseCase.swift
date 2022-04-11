import RxCocoa
import RxSwift

public final class LogoutUseCase {
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    private let authRepository: AuthRepository
    
    public func execute() -> Completable {
        authRepository.logout()
    }
}
