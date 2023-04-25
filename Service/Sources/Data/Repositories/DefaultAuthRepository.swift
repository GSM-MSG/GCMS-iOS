import RxSwift
import FirebaseMessaging

final class DefaultAuthRepository: AuthRepository {
    private let authRemote: any AuthRemoteProtocol
    private let keychainLocal: any KeychainLocalProtocol

    init(
        authRemote: any AuthRemoteProtocol,
        keychainLocal: any KeychainLocalProtocol
    ) {
        self.authRemote = authRemote
        self.keychainLocal = keychainLocal
    }

    func login(code: String) -> Completable {
        return authRemote.login(code: code)
            .asCompletable()
    }

    func refresh() -> Completable {
        return authRemote.refresh()
    }

    func logout() -> Completable {
        return authRemote.logout()
            .do(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.keychainLocal.deleteAccessToken()
                self.keychainLocal.deleteRefreshToken()
                self.keychainLocal.deleteAccessExp()
                self.keychainLocal.deleteRefreshExp()
            })
    }
}
