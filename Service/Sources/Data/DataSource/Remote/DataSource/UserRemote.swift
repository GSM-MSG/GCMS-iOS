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
    
    func fetchSearchUser(query: ClubRequestQuery) -> Single<[User]> {
        request(.search(name: query.q, type: query.type))
            .map(UserSearchResponse.self)
            .map { $0.toDomain() }
    }
    
    func clubExit(query: ClubRequestQuery) -> Completable {
        request(.exit(query))
            .asCompletable()
    }
    
}
