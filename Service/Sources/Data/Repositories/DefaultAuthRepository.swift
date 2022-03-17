import RxSwift
import FirebaseMessaging
final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    private let keychainLocal = KeychainLocal.shared
    func login(req: LoginRequest, isTest: Bool = false) -> Completable {
        return authRemote.login(req: req, isTest: isTest)
            .do(onSuccess: { [weak self] token in
                self?.keychainLocal.saveAccessToken(token.accessToken)
                self?.keychainLocal.saveRefreshToken(token.refreshToken)
            }).asCompletable()
    }
    func register(req: RegisterReqeust, isTest: Bool) -> Completable {
        return authRemote.register(req: req, isTest: isTest)
    }
}

private extension DefaultAuthRepository {
    /// 디바이스 토큰 가져오는 API
    func fetchDeviceToken() -> Single<String> {
        return Single<String>.create { single in
            Messaging.messaging().token { token, _ in
                single(.success(token ?? ""))
            }
            return Disposables.create()
        }
    }
}
