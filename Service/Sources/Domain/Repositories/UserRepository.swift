import RxSwift

public protocol UserRepository {
     func fetchUerInfo(isTest: Bool) -> Single<User>
     func fetchNoticeList(isTest: Bool) -> Single<[Notice]>
     func editProfile(url: String, isTest: Bool) -> Completable
     func acceptClub(name: String, type: ClubType, isTest: Bool) -> Completable
     func rejectClub(name: String, type: ClubType, isTest: Bool) -> Completable
     func searchUser(query: String, isTest: Bool) -> Single<[User]>
 }
