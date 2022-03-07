import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote = ClubRemote.shared
    
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable {
        return clubRemote.newClub(req: req, isTest: isTest)
    }
    func managementClub(isTest: Bool) -> Single<[ClubList]> {
        return clubRemote.managementClub(isTest: isTest)
            .map { $0.toDomain() }
    }
}
