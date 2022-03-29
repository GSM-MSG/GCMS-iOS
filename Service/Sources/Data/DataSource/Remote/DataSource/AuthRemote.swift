import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}
    
    func login(req: LoginRequest) -> Single<TokenDTO> {
        return request(.login(req: req))
            .map(TokenDTO.self)
    }
    func register(req: RegisterReqeust) -> Completable {
        return request(.register(req: req))
            .asCompletable()
    }
    func refresh() -> Completable {
        return request(.refresh)
            .asCompletable()
    }
    func sendVerify(email: String) -> Completable {
        return request(.verify(email: email))
            .asCompletable()
    }
    func isVerified(email: String) -> Completable {
        return request(.isVerified(email: email))
            .asCompletable()
    }
}
