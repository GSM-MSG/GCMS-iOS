import RxSwift
import FirebaseMessaging
final class DefaultAuthRepository: AuthRepository {
    private let authRemote = AuthRemote.shared
    private let keychainLocal = KeychainLocal.shared
    func login(idToken: String, isTest: Bool = false) -> Completable {
        return fetchDeviceToken()
            .flatMapCompletable { deviceOoken in
                return self.authRemote.login(req: .init(idToken: idToken, deviceToken: deviceOoken), isTest: isTest)
                    .do(onSuccess: { tokenDTO in
                        self.keychainLocal.saveAccessToken(tokenDTO.accessToken)
                        self.keychainLocal.saveRefreshToken(tokenDTO.refreshToken)
                    }).asCompletable()
            }
    }
}

private extension DefaultAuthRepository {
    func fetchDeviceToken() -> Single<String> {
        return .create { single in
            Messaging.messaging().token { token, _ in
                single(.success(token ?? ""))
            }
            return Disposables.create()
        }
    }
}
