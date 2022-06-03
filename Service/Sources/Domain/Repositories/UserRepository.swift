import RxSwift

public protocol UserRepository {
    func fetchMyProfile() -> Single<UserProfile>
    func updateProfileImage(imageUrl: String) -> Completable
    func searchUser(name: String, type: ClubType) -> Single<[User]>
    func clubExit(query: ClubRequestQuery) -> Completable
    func withdrawal() -> Completable
}
