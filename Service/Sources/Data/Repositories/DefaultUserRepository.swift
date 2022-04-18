import RxSwift
import Foundation

final class DefaultUserRepository: UserRepository {
    private let userRemote = UserRemote.shared
    
    func fetchProfile() -> Single<UserProfile> {
        userRemote.fetchProfile()
    }
    
    func updateProfileImage(imageUrl: String) -> Completable {
        userRemote.updateProfileImage(imageUrl: imageUrl)
    }
    
    func fetchSearchUser(query: ClubRequestQuery) -> Single<[User]> {
        userRemote.fetchSearchUser(query: query)
    }
    
    func clubExit(query: ClubRequestQuery) -> Completable {
        userRemote.clubExit(query: query)
    }
    
}
