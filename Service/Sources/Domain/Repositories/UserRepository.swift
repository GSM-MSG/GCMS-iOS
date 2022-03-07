import RxSwift
import Foundation

protocol UserRepository {
    func fetchUerInfo(isTest: Bool) -> Single<User>
    func fetchNoticeList(isTest: Bool) -> Single<[Notice]>
    func editProfile(data: Data, isTest: Bool) -> Completable
    func acceptClub(clubId: Int, isTest: Bool) -> Completable
    func rejectClub(clubId: Int, isTest: Bool) -> Completable
    func searchUser(query: String) -> Single<[User]>
}
