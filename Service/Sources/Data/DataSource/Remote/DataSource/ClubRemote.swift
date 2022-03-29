import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        request(.clubList(type: type))
            .map(ClubListResponse.self)
            .map { $0.toDomain() }
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
    func updateClub(query: ClubRequestQuery, req: NewClubRequest) -> Completable {
        request(.updateClub(query: query, req: req))
            .asCompletable()
    }
    func deleteClub(query: ClubRequestQuery) -> Completable {
        request(.deleteClub(query: query))
            .asCompletable()
    }
    func fetchClubMember(query: ClubRequestQuery) -> Single<[User]> {
        request(.clubMember(query: query))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }
    func fetchClubApplicant(query: ClubRequestQuery) -> Single<[User]> {
        request(.clubApplicant(query: query))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }
    func userAccept(query: ClubRequestQuery, userId: String) -> Completable {
        request(.userAccept(query: query, userId: userId))
            .asCompletable()
    }
    func userReject(query: ClubRequestQuery, userId: String) -> Completable {
        request(.userReject(query: query, userId: userId))
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
    func userKick(query: ClubRequestQuery, userId: String) -> Completable {
        request(.userKick(query: query, userId: userId))
            .asCompletable()
    }
}
