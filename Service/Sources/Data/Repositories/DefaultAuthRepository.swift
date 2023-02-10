import RxSwift
import FirebaseMessaging

final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    private let keychainLocal = KeychainLocal.shared
    func login(code: String) -> Completable {
        return authRemote.login(code: code)
            .asCompletable()
    }
    func refresh() -> Completable {
        return authRemote.refresh()
    }
    func logout() -> Completable {
        keychainLocal.deleteAccessToken()
        keychainLocal.deleteRefreshToken()
        keychainLocal.deleteAccessExp()
        keychainLocal.deleteRefreshExp()
        return authRemote.logout()
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
