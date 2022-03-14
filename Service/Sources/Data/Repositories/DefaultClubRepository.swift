import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote = ClubRemote.shared
    
    func createNewClub(req: NewClubRequest, isTest: Bool = false) -> Completable {
        clubRemote.newClub(req: req, isTest: isTest)
    }
    func fetchManagementClub(isTest: Bool = false) -> Single<[ClubList]> {
        clubRemote.managementClub(isTest: isTest)
            .map { $0.toDomain() }
    }
    func fetchClubList(type: ClubType, isTest: Bool = false) -> Single<[ClubList]> {
        clubRemote.fetchClubList(type: type, isTest: isTest)
            .map { $0.toDomain() }
    }
    func fetchDetailClub(name: String, type: ClubType, isTest: Bool) -> Single<DetailClub> {
        clubRemote.fetchDetailClub(name: name, type: type, isTest: isTest)
            .map { $0.toDomain() }
    }
}
