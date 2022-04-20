import RxSwift

public protocol UserRepository {
    func fetchMyProfile() -> Single<UserProfile>
    func updateProfileImage(imageUrl: String) -> Completable
    func fetchSearchUser(query: ClubRequestQuery) -> Single<[User]>
    func clubExit(query: ClubRequestQuery) -> Completable
}
