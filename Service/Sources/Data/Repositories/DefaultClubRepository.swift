import RxSwift

final class DefaultClubRepository: ClubRepository {
    
    private let clubRemote = ClubRemote.shared
    
    func createNewClub(req: NewClubRequest, isTest: Bool = false) -> Completable {
        clubRemote.newClub(req: req, isTest: isTest)
    }
    func fetchManagementClub(isTest: Bool = false) -> Single<[ClubList]> {
        clubRemote.managementClub(isTest: isTest)
    }
    func fetchClubList(type: ClubType, isTest: Bool = false) -> Single<[ClubList]> {
        clubRemote.fetchClubList(type: type, isTest: isTest)
    }
    func fetchDetailClub(name: String, type: ClubType, isTest: Bool = false) -> Single<DetailClub> {
        clubRemote.fetchDetailClub(name: name, type: type, isTest: isTest)
    }
    func joinClub(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        clubRemote.joinClub(name: name, type: type, isTest: isTest)
    }
    func fetchClubMembers(name: String, type: ClubType, isTest: Bool = false) -> Single<[User]> {
        clubRemote.fetchClubMembers(name: name, type: type, isTest: isTest)
    }
    func userAccept(userId: Int, name: String, type: ClubType, isTest: Bool = false) -> Completable {
        clubRemote.userAccept(userId: userId, name: name, type: type, isTest: isTest)
    }
    func userReject(userId: Int, name: String, type: ClubType, isTest: Bool = false) -> Completable {
        clubRemote.userReject(userId: userId, name: name, type: type, isTest: isTest)
    }
    func fetchClubWaitList(name: String, type: ClubType, isTest: Bool = false) -> Single<[User]> {
        clubRemote.fetchClubWaitList(name: name, type: type, isTest: isTest)
    }
    func clubEnd(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        clubRemote.endClub(name: name, type: type, isTest: isTest)
    }
    func clubNotification(name: String, type: ClubType, req: NotificationRequest, isTest: Bool = false) -> Completable {
        clubRemote.clubNotification(name: name, type: type, req: req, isTest: isTest)
    }
}
