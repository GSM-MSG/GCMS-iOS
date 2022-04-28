import RxSwift
import Foundation

final class DefaultUserRepository: UserRepository {
    private let userRemote = UserRemote.shared
    
    func fetchMyProfile() -> Single<UserProfile> {
        userRemote.fetchProfile()
    }
    
    func updateProfileImage(imageUrl: String) -> Completable {
        userRemote.updateProfileImage(imageUrl: imageUrl)
    }
    
    func searchUser(name: String, type: ClubType) -> Single<[User]> {
        userRemote.fetchSearchUser(name: name, type: type)
    }
    
    func clubExit(query: ClubRequestQuery) -> Completable {
        userRemote.clubExit(query: query)
    }
    
}
