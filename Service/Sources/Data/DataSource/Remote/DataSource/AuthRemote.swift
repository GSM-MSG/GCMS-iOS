import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}
    
    func login(code: String) -> Single<TokenDTO> {
        return request(.login(code: code))
            .map(TokenDTO.self)
    }
    func refresh() -> Completable {
        return request(.refresh)
            .asCompletable()
    }
}
