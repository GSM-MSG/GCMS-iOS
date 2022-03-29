import RxSwift
import FirebaseMessaging
final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    private let keychainLocal = KeychainLocal.shared
    func login(req: LoginRequest) -> Completable {
        return authRemote.login(req: req)
            .asCompletable()
    }
    func register(req: RegisterReqeust) -> Completable {
        return authRemote.register(req: req)
    }
    func refresh() -> Completable {
        return authRemote.refresh()
    }
    func sendVerify(email: String) -> Completable {
        return authRemote.sendVerify(email: email)
    }
    func isVerified(email: String) -> Completable {
        return authRemote.isVerified(email: email)
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
