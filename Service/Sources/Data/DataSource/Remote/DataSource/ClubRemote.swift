import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func newClub(req: NewClubRequest, isTest: Bool = false) -> Completable {
        return request(.newClub(req: req), isTest: isTest)
            .asCompletable()
    }
    func managementClub(isTest: Bool = false) -> Single<[ClubList]> {
        return request(.managementList, isTest: isTest)
            .map(ManagementClubResponse.self)
            .map { $0.toDomain() }
    }
    func fetchClubList(type: ClubType, isTest: Bool = false) -> Single<[ClubList]> {
        return request(.clubList(type: type), isTest: isTest)
            .map(ClubListResponse.self)
            .map { $0.toDomain() }
    }
    func fetchDetailClub(name: String, type: ClubType, isTest: Bool = false) -> Single<DetailClub> {
        return request(.detailClub(name: name, type: type), isTest: isTest)
            .map(DetailClubResponse.self)
            .map { $0.toDomain() }
    }
    func joinClub(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        return request(.join(name: name, type: type), isTest: isTest)
            .asCompletable()
    }
    func fetchClubMembers(name: String, type: ClubType, isTest: Bool = false) -> Single<[User]> {
        return request(.members(name: name, type: type), isTest: isTest)
            .map(ClubMembersResponse.self)
            .map { $0.toDomain() }
    }
    func userAccept(
        userId: Int,
        name: String,
        type: ClubType,
        isTest: Bool = false
    ) -> Completable {
        return request(.userAccept(userId: userId, name: name, type: type), isTest: isTest)
            .asCompletable()
    }
    func userReject(
        userId: Int,
        name: String,
        type: ClubType,
        isTest: Bool = false
    ) -> Completable {
        return request(.userReject(userId: userId, name: name, type: type), isTest: isTest)
            .asCompletable()
    }
    func fetchClubWaitList(
        name: String,
        type: ClubType,
        isTest: Bool = false
    ) -> Single<[User]> {
        return request(.waitList(name: name, type: type), isTest: isTest)
            .map(ClubWaitListResponse.self)
            .map { $0.toDomain() }
    }
    func endClub(
        name: String,
        type: ClubType,
        isTest: Bool = false
    ) -> Completable {
        return request(.end(name: name, type: type), isTest: isTest)
            .asCompletable()
    }
    func clubNotification(
        name: String,
        type: ClubType,
        req: NotificationRequest,
        isTest: Bool = false
    ) -> Completable {
        return request(.notification(name: name, type: type, req: req), isTest: isTest)
            .asCompletable()
    }
}
