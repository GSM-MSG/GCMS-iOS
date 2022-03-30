import RxSwift

public protocol AuthRepository {
    func login(req: LoginRequest) -> Completable
    func register(req: RegisterReqeust) -> Completable
    func refresh() -> Completable
    func sendVerify(email: String, code: String) -> Completable
    func isVerified(email: String, code: String) -> Completable
}
