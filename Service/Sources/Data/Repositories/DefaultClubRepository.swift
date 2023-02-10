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
    func clubOpen(query: ClubRequestQuery) -> Completable {
        clubRemote.clubOpen(query: query)
    }
    func clubClose(query: ClubRequestQuery) -> Completable {
        clubRemote.clubClose(query: query)
    }
    func cancel(query: ClubRequestQuery) -> Completable {
        clubRemote.cancel(query: query)
    }
}
