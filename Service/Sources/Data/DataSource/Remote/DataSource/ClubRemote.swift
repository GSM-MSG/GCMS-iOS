import RxSwift

protocol ClubRemoteProtocol {
    func fetchClubList(type: ClubType) -> Single<[ClubList]>
    func fetchDetailClub(clubID: Int) -> Single<Club>
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
