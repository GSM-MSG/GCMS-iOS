import RxSwift
import FirebaseMessaging

final class AuthRemote: BaseRemote<AuthAPI> {
    static let shared = AuthRemote()
    private override init() {}

    func login(code: String) -> Single<TokenDTO> {
        return request(.login(code: code, deviceToken: Messaging.messaging().fcmToken ?? ""))
            .map(TokenDTO.self)
    }

    func refresh() -> Completable {
        return request(.refresh(deviceToken: Messaging.messaging().fcmToken ?? ""))
            .asCompletable()
    }

    func logout() -> Completable {
        return request(.logout)
            .asCompletable()
    }
}
