import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        request(.clubList(type: type))
            .map([ClubListDTO].self)
            .map { $0.map { $0.toDomain() } }
    }
    func fetchGuestClubList(type: ClubType) -> Single<[ClubList]> {
        request(.guestClubList(type: type))
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
    func fetchClubMember(query: ClubRequestQuery) -> Single<[Member]> {
        request(.clubMember(query: query))
            .map([ClubMemberResponse].self)
            .map { $0.map { $0.toDomain() } }
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
    func apply(query: ClubRequestQuery) -> Completable {
        request(.apply(query: query))
            .asCompletable()
    }
    func cancel(query: ClubRequestQuery) -> Completable {
        request(.cancel(query: query))
            .asCompletable()
    }
    func delegation(query: ClubRequestQuery, userId: String) -> Completable {
        request(.delegation(query: query, userId: userId))
            .asCompletable()
    }
}
