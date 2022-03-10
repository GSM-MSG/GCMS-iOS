import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func newClub(req: NewClubRequest, isTest: Bool = false) -> Completable {
        return request(.newClub(req: req), isTest: isTest)
            .asCompletable()
    }
    func managementClub(isTest: Bool = false) -> Single<ManagementClubResponse> {
        return request(.managementList, isTest: isTest)
            .map(ManagementClubResponse.self)
    }
    func fetchClubList(type: ClubType, isTest: Bool = false) -> Single<ClubListResponse> {
        return request(.clubList(type: type), isTest: isTest)
            .map(ClubListResponse.self)
    }
    func fetchDetailClub(id: Int, isTest: Bool = false) -> Single<DetailClubResponse> {
        return request(.detailClub(id), isTest: isTest)
            .map(DetailClubResponse.self)
    }
}
