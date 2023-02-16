import RxSwift

public protocol UserRepository {
    func fetchMyProfile() -> Single<UserProfile>
    func updateProfileImage(imageUrl: String) -> Completable
    func fetchMiniProfile() -> Single<MiniProfile>
    func searchUser(name: String, type: ClubType) -> Single<[User]>
    func withdrawal() -> Completable
}
