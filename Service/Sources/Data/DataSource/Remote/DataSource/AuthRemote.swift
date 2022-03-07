import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}
    
    func login(req: LoginRequest, isTest: Bool = false) -> Single<TokenDTO> {
        return request(.login(req: req), isTest: isTest)
            .map(TokenDTO.self)
    }
}
