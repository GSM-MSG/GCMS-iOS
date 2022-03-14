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
    
    func acceptClub(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        userRemote.accept(name: name, type: type, isTest: isTest)
    }
    
    func rejectClub(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        userRemote.reject(name: name, type: type, isTest: isTest)
    }
    
    func searchUser(query: String, isTest: Bool = false) -> Single<[User]> {
        userRemote.search(q: query, isTest: isTest)
            .map { $0.toDomain() }
    }
    
}
