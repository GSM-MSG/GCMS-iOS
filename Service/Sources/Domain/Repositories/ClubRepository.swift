import RxSwift

public protocol ClubRepository {
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable
    func fetchManagementClub(isTest: Bool) -> Single<[ClubList]>
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]>
    func fetchDetailClub(name: String, type: ClubType, isTest: Bool) -> Single<DetailClub>
}
