import RxSwift

public protocol ClubRepository {
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]>
    func fetchDetailClub(query: ClubRequestQuery, isTest: Bool) -> Single<Club>
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable
    func updateClub(query: ClubRequestQuery, req: NewClubRequest, isTest: Bool) -> Completable
    func deleteClub(query: ClubRequestQuery, isTest: Bool) -> Completable
    func fetchClubMember(query: ClubRequestQuery, isTest: Bool) -> Single<[User]>
    func fetchClubApplicant(query: ClubRequestQuery, isTest: Bool) -> Single<[User]>
    func userAccept(query: ClubRequestQuery, userId: String, isTest: Bool) -> Completable
    func userReject(query: ClubRequestQuery, userId: String, isTest: Bool) -> Completable
    func clubOpen(query: ClubRequestQuery, isTest: Bool) -> Completable
    func clubClose(query: ClubRequestQuery, isTest: Bool) -> Completable
    func userKick(query: ClubRequestQuery, userId: String, isTest: Bool) -> Completable
}
