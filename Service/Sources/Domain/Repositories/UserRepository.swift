import RxSwift

public protocol UserRepository {
    func fetchProfile() -> Single<UserProfile>
    func updateProfileImage(imageUrl: String) -> Completable
    func fetchUser(query: ClubRequestQuery) -> Single<[User]>
    func clubExit(query: ClubRequestQuery) -> Completable
}
