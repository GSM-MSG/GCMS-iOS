import RxSwift
import Foundation

final class DefaultUserRepository: UserRepository {
    private let userRemote: any UserRemoteProtocol

    init(userRemote: any UserRemoteProtocol) {
        self.userRemote = userRemote
    }

    func fetchMyProfile() -> Single<UserProfile> {
        userRemote.fetchProfile()
    }

    func updateProfileImage(imageUrl: String) -> Completable {
        userRemote.updateProfileImage(imageUrl: imageUrl)
    }

    func fetchMiniProfile() -> Single<MiniProfile> {
        userRemote.fetchMiniProfile()
    }

    func searchUser(name: String, type: ClubType) -> Single<[User]> {
        userRemote.fetchSearchUser(name: name, type: type)
    }

    func withdrawal() -> Completable {
        userRemote.withdrawal()
    }
}
