import RxSwift
import FirebaseMessaging

final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    private let keychainLocal = KeychainLocal.shared
    func login(idToken: String) -> Completable {
        return authRemote.login(idToken: idToken)
            .asCompletable()
    }
    func refresh() -> Completable {
        return authRemote.refresh()
    }
    func logout() -> Completable {
        keychainLocal.deleteAccessToken()
        keychainLocal.deleteRefreshToken()
        keychainLocal.deleteExpiredAt()
        return Completable.create { completable in            
            completable(.completed)
            return Disposables.create()
        }
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
