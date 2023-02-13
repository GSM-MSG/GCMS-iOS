import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        request(.clubList(type: type))
            .map([ClubListDTO].self)
            .map { $0.map { $0.toDomain() } }
    }
    func fetchDetailClub(clubID: Int) -> Single<Club> {
        request(.clubDetail(clubID: clubID))
            .map(DetailClubResponse.self)
            .map { $0.toDomain() }
    }
    func createNewClub(req: NewClubRequest) -> Completable {
        request(.createNewClub(req: req))
            .asCompletable()
    }
    func updateClub(clubID: Int ,req: UpdateClubRequest) -> Completable {
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
