import RxSwift

public protocol ClubRepository {
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]>
    func fetchDetailClub(query: ClubRequestComponent, isTest: Bool) -> Single<Club>
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable
    func updateClub(query: ClubRequestComponent, req: NewClubRequest, isTest: Bool) -> Completable
    func deleteClub(query: ClubRequestComponent, isTest: Bool) -> Completable
    func fetchClubMember(query: ClubRequestComponent, isTest: Bool) -> Single<[User]>
    func fetchClubApplicant(query: ClubRequestComponent, isTest: Bool) -> Single<[User]>
    func userAccept(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable
    func userReject(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable
    func clubOpen(query: ClubRequestComponent, isTest: Bool) -> Completable
    func clubClose(query: ClubRequestComponent, isTest: Bool) -> Completable
    func userKick(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable
}
