import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}
    
    func login(req: LoginRequest, isTest: Bool = false) -> Single<TokenDTO> {
        return request(.login(req: req), isTest: isTest)
            .map(TokenDTO.self)
    }
    func register(req: RegisterReqeust, isTest: Bool = false) -> Completable {
        return request(.register(req: req), isTest: isTest)
            .asCompletable()
    }
    func refresh(isTest: Bool = false) -> Completable {
        return request(.refresh, isTest: isTest)
            .asCompletable()
    }
    func sendVerify(email: String, isTest: Bool = false) -> Completable {
        return request(.verify(email: email), isTest: isTest)
            .asCompletable()
    }
    func isVerified(email: String, isTest: Bool = false) -> Completable {
        return request(.isVerified(email: email), isTest: isTest)
            .asCompletable()
    }
}
