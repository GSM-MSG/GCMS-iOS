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
    func fetchDetailClub(clubID: String) -> Single<Club> {
        clubRemote.fetchDetailClub(clubID: clubID)
    }
    func createNewClub(req: NewClubRequest) -> Completable {
        clubRemote.createNewClub(req: req)
    }
    func updateClub(clubID: String, req: UpdateClubRequest) -> Completable {
        clubRemote.updateClub(clubID: clubID, req: req)
    }
    func deleteClub(clubID: String) -> Completable {
        clubRemote.deleteClub(clubID: clubID)
    }
    func clubOpen(clubID: String) -> Completable {
        clubRemote.clubOpen(clubID: clubID)
    }
    func clubClose(clubID: String) -> Completable {
        clubRemote.clubClose(clubID: clubID)
    }
    func exitClub(clubID: String) -> Completable {
        clubRemote.exitClub(clubID: clubID)
    }
}
