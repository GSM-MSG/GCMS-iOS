import RxSwift

public protocol ClubRepository {
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable
    func fetchManagementClub(isTest: Bool) -> Single<[ClubList]>
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]>
    func fetchDetailClub(name: String, type: ClubType, isTest: Bool) -> Single<DetailClub>
    func joinClub(name: String, type: ClubType, isTest: Bool) -> Completable
    func fetchClubMembers(name: String, type: ClubType, isTest: Bool) -> Single<[User]>
    func userAccept(userId: Int, name: String, type: ClubType, isTest: Bool) -> Completable
    func userReject(userId: Int, name: String, type: ClubType, isTest: Bool) -> Completable
    func fetchClubWaitList(name: String, type: ClubType, isTest: Bool) -> Single<[User]>
    func clubEnd(name: String, type: ClubType, isTest: Bool) -> Completable
    func clubNotification(name: String, type: ClubType, req: NotificationRequest, isTest: Bool) -> Completable
}
