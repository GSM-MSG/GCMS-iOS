import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote = ClubRemote.shared
    
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        clubRemote.fetchClubList(type: type)
    }
    
    func fetchDetailClub(query: ClubRequestQuery) -> Single<Club> {
        clubRemote.fetchDetailClub(query: query)
    }
    
    func createNewClub(req: NewClubRequest) -> Completable {
        clubRemote.createNewClub(req: req)
    }
    
    func updateClub(query: ClubRequestQuery, req: NewClubRequest) -> Completable {
        clubRemote.updateClub(query: query, req: req)
    }
    
    func deleteClub(query: ClubRequestQuery) -> Completable {
        clubRemote.deleteClub(query: query)
    }
    
    func fetchClubMember(query: ClubRequestQuery) -> Single<[Member]> {
        clubRemote.fetchClubMember(query: query)
    }
    
    func fetchClubApplicant(query: ClubRequestQuery) -> Single<[User]> {
        clubRemote.fetchClubApplicant(query: query)
    }
    
    func userAccept(query: ClubRequestQuery, userId: String) -> Completable {
        clubRemote.userAccept(query: query, userId: userId)
    }
    
    func userReject(query: ClubRequestQuery, userId: String) -> Completable {
        clubRemote.userReject(query: query, userId: userId)
    }
    
    func clubOpen(query: ClubRequestQuery) -> Completable {
        clubRemote.clubOpen(query: query)
    }
    
    func clubClose(query: ClubRequestQuery) -> Completable {
        clubRemote.clubClose(query: query)
    }
    
    func userKick(query: ClubRequestQuery, userId: String) -> Completable {
        clubRemote.userKick(query: query, userId: userId)
    }
}
