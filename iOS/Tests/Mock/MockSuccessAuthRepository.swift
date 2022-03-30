@testable import Service
import RxSwift
import Then

class MockSuccessAuthRepository: AuthRepository{
    private let authRemote: AuthRemote = {
        let auth = AuthRemote.shared
        auth.testStatus = true
        auth.successStatus = true
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
    
    func sendVerify(email: String, code: String) -> Completable {
        authRemote.sendVerify(email: email, code: code)
    }
    
    func isVerified(email: String, code: String) -> Completable {
        authRemote.isVerified(email: email, code: code)
    }
}
