import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]> {
        request(.clubList(type: type), isTest: isTest)
            .map(ClubListResponse.self)
            .map { $0.toDomain() }
    }
    func fetchDetailClub(query: ClubRequestComponent, isTest: Bool) -> Single<Club> {
        request(.clubDetail(query: query), isTest: isTest)
            .map(DetailClubResponse.self)
            .map { $0.toDomain() }
    }
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable {
        request(.createNewClub(req: req), isTest: isTest)
            .asCompletable()
    }
    func updateClub(query: ClubRequestComponent, req: NewClubRequest, isTest: Bool) -> Completable {
        request(.updateClub(query: query, req: req), isTest: isTest)
            .asCompletable()
    }
    func deleteClub(query: ClubRequestComponent, isTest: Bool) -> Completable {
        request(.deleteClub(query: query), isTest: isTest)
            .asCompletable()
    }
    func fetchClubMember(query: ClubRequestComponent, isTest: Bool) -> Single<[User]> {
        request(.clubMember(query: query), isTest: isTest)
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }
    func fetchClubApplicant(query: ClubRequestComponent, isTest: Bool) -> Single<[User]> {
        request(.clubApplicant(query: query), isTest: isTest)
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }
    func userAccept(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable {
        request(.userAccept(query: query, userId: userId), isTest: isTest)
            .asCompletable()
    }
    func userReject(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable {
        request(.userReject(query: query, userId: userId), isTest: isTest)
            .asCompletable()
    }
    func clubOpen(query: ClubRequestComponent, isTest: Bool) -> Completable {
        request(.clubOpen(query: query), isTest: isTest)
            .asCompletable()
    }
    func clubClose(query: ClubRequestComponent, isTest: Bool) -> Completable {
        request(.clubClose(query: query), isTest: isTest)
            .asCompletable()
    }
    func userKick(query: ClubRequestComponent, userId: String, isTest: Bool) -> Completable {
        request(.userKick(query: query, userId: userId), isTest: isTest)
            .asCompletable()
    }
}
