import RxSwift

public protocol ClubRepository {
    func fetchClubList(type: ClubType) -> Observable<[ClubList]>
    func fetchDetailClub(clubID: Int) -> Single<Club>
    func createNewClub(req: NewClubRequest) -> Completable
    func updateClub(clubID: Int, req: UpdateClubRequest) -> Completable
    func deleteClub(clubID: Int) -> Completable
    func clubOpen(clubID: Int) -> Completable
    func clubClose(clubID: Int) -> Completable
    func exitClub(clubID: Int) -> Completable
}
