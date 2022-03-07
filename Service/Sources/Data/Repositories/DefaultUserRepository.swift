import RxSwift
import Foundation

final class DefaultUserRepository: UserRepository {
    private let userRemote = UserRemote.shared
    func fetchUerInfo(isTest: Bool = false) -> Single<User> {
        userRemote.userInfo(isTest: isTest)
            .map { $0.toDomain() }
    }
    func fetchNoticeList(isTest: Bool = false) -> Single<[Notice]> {
        userRemote.notice(isTest: isTest)
            .map { $0.toDomain() }
    }
    func editProfile(url: String, isTest: Bool = false) -> Completable {
        userRemote.editPicture(url: url, isTest: isTest)
    }
    
    func acceptClub(clubId: Int, isTest: Bool = false) -> Completable {
        userRemote.accept(clubId: clubId, isTest: isTest)
    }
    
    func rejectClub(clubId: Int, isTest: Bool = false) -> Completable {
        userRemote.reject(clubId: clubId, isTest: isTest)
    }
    
    func searchUser(query: String, isTest: Bool = false) -> Single<[User]> {
        userRemote.search(q: query, isTest: isTest)
            .map { $0.toDomain() }
    }
    
}
