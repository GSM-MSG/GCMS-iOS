import RxSwift

final class UserRemote: BaseRemote<UserAPI> {
    static let shared = UserRemote()
    private override init() {}
    
    func fetchProfile() -> Single<UserProfile> {
        request(.userInfo)
            .map(UserProfileResponse.self)
            .map { $0.toDomain() }
    }
    
    func updateProfileImage(imageUrl: String) -> Completable {
        request(.editProfile(url: imageUrl))
            .asCompletable()
    }
    
    func fetchUser(query: ClubRequestQuery) -> Single<[User]> {
        request(.search(name: query.name, type: query.type))
            .map(UserSearchResponse.self)
            .map { $0.toDomain() }
    }
    
    func clubExit(query: ClubRequestQuery) -> Completable {
        request(.secession(name: query.name, type: query.type))
            .asCompletable()
    }
    
}
