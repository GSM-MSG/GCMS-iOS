import RxSwift

protocol ClubRemoteProtocol {
    func fetchClubList(type: ClubType) -> Single<[ClubList]>
    func fetchDetailClub(clubID: Int) -> Single<Club>
    func updateClub(clubID: Int, req: UpdateClubRequest) -> Completable
    func deleteClub(clubID: Int) -> Completable
    func clubOpen(clubID: Int) -> Completable
    func clubClose(clubID: Int) -> Completable
    func exitClub(clubID: Int) -> Completable
}

final class ClubRemote: BaseRemote<ClubAPI>, ClubRemoteProtocol {
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        request(.clubList(type: type))
            .map([SingleClubListResponse].self)
            .map { $0.map { $0.toDomain() } }
    }

    func fetchDetailClub(clubID: Int) -> Single<Club> {
        request(.clubDetail(clubID: clubID))
            .map(FetchDetailClubResponse.self)
            .map { $0.toDomain() }
    }

    func updateClub(clubID: Int, req: UpdateClubRequest) -> Completable {
        request(.updateClub(clubID: clubID, req: req))
            .asCompletable()
    }

    func deleteClub(clubID: Int) -> Completable {
        request(.deleteClub(clubID: clubID))
            .asCompletable()
    }

    func clubOpen(clubID: Int) -> Completable {
        request(.clubOpen(clubID: clubID))
            .asCompletable()
    }

    func clubClose(clubID: Int) -> Completable {
        request(.clubClose(clubID: clubID))
            .asCompletable()
    }

    func exitClub(clubID: Int) -> Completable {
        request(.exitClub(clubID: clubID))
            .asCompletable()
    }
}
