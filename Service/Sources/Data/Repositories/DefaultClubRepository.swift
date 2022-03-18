import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote = ClubRemote.shared
    
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]> {
        clubRemote.fetchClubList(type: type, isTest: isTest)
    }
    
    func fetchDetailClub(query: ClubRequestComponent, isTest: Bool) -> Single<Club> {
        clubRemote.fetchDetailClub(query: query, isTest: isTest)
    }
    
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable {
        clubRemote.createNewClub(req: req, isTest: isTest)
    }
    
    func updateClub(query: ClubRequestComponent, req: NewClubRequest, isTest: Bool) -> Completable {
        clubRemote.updateClub(query: query, req: req, isTest: isTest)
    }
    
    func deleteClub(query: ClubRequestComponent, isTest: Bool) -> Completable {
        clubRemote.deleteClub(query: query, isTest: isTest)
    }
    
    func fetchClubMember(query: ClubRequestComponent, isTest: Bool) -> Single<[User]> {
        clubRemote.fetchClubMember(query: query, isTest: isTest)
    }
    
    func fetchClubApplicant(query: ClubRequestComponent, isTest: Bool) -> Single<[User]> {
        clubRemote.fetchClubApplicant(query: query, isTest: isTest)
    }
    
    func userAccept(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable {
        clubRemote.userAccept(query: query, userId: userId, isTest: isTest)
    }
    
    func userReject(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable {
        clubRemote.userReject(query: query, userId: userId, isTest: isTest)
    }
    
    func clubOpen(query: ClubRequestComponent, isTest: Bool) -> Completable {
        clubRemote.clubOpen(query: query, isTest: isTest)
    }
    
    func clubClose(query: ClubRequestComponent, isTest: Bool) -> Completable {
        clubRemote.clubClose(query: query, isTest: isTest)
    }
    
    func userKick(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable {
        clubRemote.userKick(query: query, userId: userId, isTest: isTest)
    }
}
