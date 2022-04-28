import RxSwift

final class UserRemote: BaseRemote<UserAPI> {
    static let shared = UserRemote()
    private override init() {}
    
    func fetchProfile() -> Single<UserProfile> {
        request(.myProfile)
            .map(UserMyProfileResponse.self)
            .map { $0.toDomain() }
    }
    
    func updateProfileImage(imageUrl: String) -> Completable {
        request(.editProfile(url: imageUrl))
            .asCompletable()
    }
    
    func fetchSearchUser(name: String, type: ClubType) -> Single<[User]> {
        request(.search(name: name, type: type))
            .map(UserSearchResponse.self)
            .map { $0.toDomain() }
    }
    
    func clubExit(query: ClubRequestQuery) -> Completable {
        request(.exit(query))
            .asCompletable()
    }
    
}
