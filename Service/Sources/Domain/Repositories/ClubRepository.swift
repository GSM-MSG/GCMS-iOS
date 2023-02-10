import RxSwift

public protocol ClubRepository {
    func fetchClubList(type: ClubType) -> Observable<[ClubList]>
    func fetchDetailClub(clubID: String) -> Single<Club>
    func createNewClub(req: NewClubRequest) -> Completable
    func updateClub(clubID: String, req: UpdateClubRequest) -> Completable
    func deleteClub(clubID: String) -> Completable
    func clubOpen(clubID: String) -> Completable
    func clubClose(clubID: String) -> Completable
    func exitClub(clubID: String) -> Completable
}
