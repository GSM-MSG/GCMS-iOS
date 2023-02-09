import RxSwift

public protocol ClubRepository {
    func fetchClubList(type: ClubType) -> Observable<[ClubList]>
    func fetchDetailClub(query: ClubRequestQuery) -> Single<Club>
    func createNewClub(req: NewClubRequest) -> Completable
    func updateClub(req: UpdateClubRequest) -> Completable
    func deleteClub(query: ClubRequestQuery) -> Completable
    func fetchClubApplicant(query: ClubRequestQuery) -> Single<[User]>
    func userAccept(query: ClubRequestQuery, userId: String) -> Completable
    func userReject(query: ClubRequestQuery, userId: String) -> Completable
    func clubOpen(query: ClubRequestQuery) -> Completable
    func clubClose(query: ClubRequestQuery) -> Completable
    func apply(query: ClubRequestQuery) -> Completable
    func cancel(query: ClubRequestQuery) -> Completable
}
