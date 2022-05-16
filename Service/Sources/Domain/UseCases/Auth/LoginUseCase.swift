import RxSwift

public struct LoginUseCase {
    public init(authRepository: AuthRepository) {
        self.repository = authRepository
    }
    
    private let repository: AuthRepository
    
    public func execute(idToken: String) -> Completable {
        repository.login(idToken: idToken)
    }
}
