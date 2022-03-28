import RxSwift
import FirebaseMessaging
final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    private let keychainLocal = KeychainLocal.shared
    func login(req: LoginRequest) -> Completable {
        return authRemote.login(req: req, isTest: false)
            .asCompletable()
    }
    func register(req: RegisterReqeust) -> Completable {
        return authRemote.register(req: req, isTest: false)
    }
    func refresh() -> Completable {
        return authRemote.refresh(isTest: false)
    }
    func sendVerify(email: String) -> Completable {
        return authRemote.sendVerify(email: email, isTest: false)
    }
    func isVerified(email: String) -> Completable {
        return authRemote.isVerified(email: email, isTest: false)
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
