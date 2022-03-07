
import RxSwift

public protocol ClubRepository {
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable
    func managementClub(isTest: Bool) -> Single<[ClubList]>
}
