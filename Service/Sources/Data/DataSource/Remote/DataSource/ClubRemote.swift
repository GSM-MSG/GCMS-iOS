import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        request(.clubList(type: type))
            .map([ClubListDTO].self)
            .map { $0.map { $0.toDomain() } }
    }
    func fetchDetailClub(query: ClubRequestQuery) -> Single<Club> {
        request(.clubDetail(query: query))
            .map(DetailClubResponse.self)
            .map { $0.toDomain() }
    }
    func createNewClub(req: NewClubRequest) -> Completable {
        request(.createNewClub(req: req))
            .asCompletable()
    }
    func updateClub(req: UpdateClubRequest) -> Completable {
        request(.updateClub(req: req))
            .asCompletable()
    }
    func deleteClub(query: ClubRequestQuery) -> Completable {
        request(.deleteClub(query: query))
            .asCompletable()
    }
    func clubOpen(query: ClubRequestQuery) -> Completable {
        request(.clubOpen(query: query))
            .asCompletable()
    }
    func clubClose(query: ClubRequestQuery) -> Completable {
        request(.clubClose(query: query))
            .asCompletable()
    }
    func cancel(query: ClubRequestQuery) -> Completable {
        request(.cancel(query: query))
            .asCompletable()
    }
}
