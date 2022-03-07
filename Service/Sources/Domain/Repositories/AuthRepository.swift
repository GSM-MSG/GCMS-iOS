import RxSwift

public protocol AuthRepository {
    func login(idToken: String, isTest: Bool) -> Completable
}
