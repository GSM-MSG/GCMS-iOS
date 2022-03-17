import RxSwift

public protocol AuthRepository {
    func login(req: LoginRequest, isTest: Bool) -> Completable
    func register(req: RegisterReqeust, isTest: Bool) -> Completable
    func refresh(isTest: Bool) -> Completable
    func sendVerify(email: String, isTest: Bool) -> Completable
    func isVerified(email: String, isTest: Bool) -> Completable
}
