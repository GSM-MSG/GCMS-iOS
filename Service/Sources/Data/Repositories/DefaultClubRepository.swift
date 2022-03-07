import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote = ClubRemote.shared
    
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable {
        clubRemote.newClub(req: req, isTest: isTest)
    }
    func fetchManagementClub(isTest: Bool) -> Single<[ClubList]> {
        clubRemote.managementClub(isTest: isTest)
            .map { $0.toDomain() }
    }
}
