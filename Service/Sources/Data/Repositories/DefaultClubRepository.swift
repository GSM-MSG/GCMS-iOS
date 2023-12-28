import RxSwift

final class DefaultClubRepository: ClubRepository {
    private let clubRemote: any ClubRemoteProtocol
    private let clubLocal: any ClubLocalProtocol

    init(
        clubRemote: any ClubRemoteProtocol,
        clubLocal: any ClubLocalProtocol
    ) {
        self.clubRemote = clubRemote
        self.clubLocal = clubLocal
    }

    func fetchClubList(type: ClubType) -> Observable<[ClubList]> {
        OfflineCache<[ClubList]>()
            .localData { self.clubLocal.fetchClubList(type: type) }
            .remoteData { self.clubRemote.fetchClubList(type: type) }
            .doOnNeedRefresh { self.clubLocal.deleteClubList(); self.clubLocal.saveClubList(clubList: $0) }
            .createObservable()
    }

    func fetchDetailClub(clubID: Int) -> Single<Club> {
        clubRemote.fetchDetailClub(clubID: clubID)
    }

    func updateClub(clubID: Int, req: UpdateClubRequest) -> Completable {
        clubRemote.updateClub(clubID: clubID, req: req)
    }

    func deleteClub(clubID: Int) -> Completable {
        clubRemote.deleteClub(clubID: clubID)
    }

    func clubOpen(clubID: Int) -> Completable {
        clubRemote.clubOpen(clubID: clubID)
    }

    func clubClose(clubID: Int) -> Completable {
        clubRemote.clubClose(clubID: clubID)
    }

    func exitClub(clubID: Int) -> Completable {
        clubRemote.exitClub(clubID: clubID)
    }
}
