import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote = ClubRemote.shared
    private let clubLocal = ClubLocal.shared
    
    func fetchClubList(type: ClubType) -> Observable<[ClubList]> {
        OfflineCache<[ClubList]>()
            .localData { self.clubLocal.fetchClubList(type: type) }
            .remoteData { self.clubRemote.fetchClubList(type: type) }
            .doOnNeedRefresh { self.clubLocal.deleteClubList(); self.clubLocal.saveClubList(clubList: $0) }
            .createObservable()
    }
    func fetchDetailClub(query: ClubRequestQuery) -> Single<Club> {
        clubRemote.fetchDetailClub(query: query)
    }
    func createNewClub(req: NewClubRequest) -> Completable {
        clubRemote.createNewClub(req: req)
    }
    func updateClub(req: UpdateClubRequest) -> Completable {
        clubRemote.updateClub(req: req)
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
    func apply(query: ClubRequestQuery) -> Completable {
        clubRemote.apply(query: query)
    }
    func cancel(query: ClubRequestQuery) -> Completable {
        clubRemote.cancel(query: query)
    }
    func delegation(query: ClubRequestQuery, userId: String) -> Completable {
        clubRemote.delegation(query: query, userId: userId)
    }
}
