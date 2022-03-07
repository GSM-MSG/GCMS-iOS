import RxSwift
import Foundation

final class DefaultUserRepository: UserRepository {
    private let userRemote = UserRemote.shared
    func fetchUerInfo(isTest: Bool) -> Single<User> {
        return userRemote.userInfo(isTest: isTest)
            .map { $0.toDomain() }
    }
    func fetchNoticeList(isTest: Bool) -> Single<[Notice]> {
        return userRemote.notice(isTest: isTest)
            .map { $0.toDomain() }
    }
    func editProfile(data: Data, isTest: Bool) -> Completable {
        return .empty()
    }
    
    func acceptClub(clubId: Int, isTest: Bool) -> Completable {
        return .empty()
    }
    
    func rejectClub(clubId: Int, isTest: Bool) -> Completable {
        return .empty()
    }
    
    func searchUser(query: String) -> Single<[User]> {
        return .just([])
    }
    
}
