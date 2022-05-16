import RxSwift

public protocol AuthRepository {
    func login(idToken: String) -> Completable
    func refresh() -> Completable
    func logout() -> Completable
}
