import RxSwift

public protocol ClubRepository {
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable
    func fetchManagementClub(isTest: Bool) -> Single<[ClubList]>
}
