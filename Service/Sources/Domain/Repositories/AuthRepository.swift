import RxSwift

public protocol AuthRepository {
    func login(code: String) -> Completable
    func refresh() -> Completable
    func logout() -> Completable
}
