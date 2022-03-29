import RxSwift

public protocol ClubRepository {
    func fetchClubList(type: ClubType) -> Single<[ClubList]>
    func fetchDetailClub(query: ClubRequestQuery) -> Single<Club>
    func createNewClub(req: NewClubRequest) -> Completable
    func updateClub(query: ClubRequestQuery, req: NewClubRequest) -> Completable
    func deleteClub(query: ClubRequestQuery) -> Completable
    func fetchClubMember(query: ClubRequestQuery) -> Single<[User]>
    func fetchClubApplicant(query: ClubRequestQuery) -> Single<[User]>
    func userAccept(query: ClubRequestQuery, userId: String) -> Completable
    func userReject(query: ClubRequestQuery, userId: String) -> Completable
    func clubOpen(query: ClubRequestQuery) -> Completable
    func clubClose(query: ClubRequestQuery) -> Completable
    func userKick(query: ClubRequestQuery, userId: String) -> Completable
}
