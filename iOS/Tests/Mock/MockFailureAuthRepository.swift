@testable import Service
import RxSwift
import Then

class MockFailureAuthRepository: AuthRepository{
    private let authRemote: AuthRemote = {
        let auth = AuthRemote.shared
        auth.testStatus = true
        auth.successStatus = false
        return auth
    }()
    
    func login(req: LoginRequest) -> Completable {
        authRemote.login(req: req).asCompletable()
    }
    
    func register(req: RegisterReqeust) -> Completable {
        authRemote.register(req: req)
    }
    
    func refresh() -> Completable {
        authRemote.refresh()
        
    }
    
    func sendVerify(email: String) -> Completable {
        authRemote.sendVerify(email: email)
    }
    
    func isVerified(email: String) -> Completable {
        authRemote.isVerified(email: email)
    }
}
