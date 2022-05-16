import RxSwift

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}
    
    func login(idToken: String) -> Single<TokenDTO> {
        return request(.login(idToken: idToken))
            .map(TokenDTO.self)
    }
    func refresh() -> Completable {
        return request(.refresh)
            .asCompletable()
    }
}
