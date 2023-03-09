import RxSwift
import FirebaseMessaging

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}

    func login(code: String) -> Single<TokenDTO> {
        return fetchDeviceToken()
            .flatMap {
                self.request(.login(code: code, deviceToken: $0))
            }
            .map(TokenDTO.self)
    }

    func refresh() -> Completable {
        return fetchDeviceToken()
            .flatMap {
                self.request(.refresh(deviceToken: $0))
            }
            .asCompletable()
    }

    func logout() -> Completable {
        return request(.logout)
            .asCompletable()
    }
}

private extension AuthRemote {
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
