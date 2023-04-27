import RxSwift

protocol UserRemoteProtocol {
    func fetchProfile() -> Single<UserProfile>
    func updateProfileImage(imageUrl: String) -> Completable
    func fetchMiniProfile() -> Single<MiniProfile>
    func fetchSearchUser(name: String, type: ClubType) -> Single<[User]>
    func withdrawal() -> Completable
}

final class UserRemote: BaseRemote<UserAPI>, UserRemoteProtocol {
    func fetchProfile() -> Single<UserProfile> {
        request(.myProfile)
            .map(FetchMyProfileResponse.self)
            .map { $0.toDomain() }
    }

    func updateProfileImage(imageUrl: String) -> Completable {
        request(.editProfile(url: imageUrl))
            .asCompletable()
    }

    func fetchMiniProfile() -> Single<MiniProfile> {
        request(.miniProfile)
            .map(FetchMiniProfileResponse.self)
            .map { $0.toDomain() }
    }

    func fetchSearchUser(name: String, type: ClubType) -> Single<[User]> {
        request(.search(name: name, type: type))
            .map([SingleUserResponse].self)
            .map { $0.map { $0.toDomain() } }
    }

    func withdrawal() -> Completable {
        request(.withdrawal)
            .asCompletable()
    }
}
