import RxSwift

public protocol AuthRepository {
    func login(req: LoginRequest, isTest: Bool) -> Completable
    func register(req: RegisterReqeust, isTest: Bool) -> Completable
}
