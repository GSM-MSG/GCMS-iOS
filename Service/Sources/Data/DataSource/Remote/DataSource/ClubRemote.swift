import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<[ClubList]> {
        request(.clubList(type: type), isTest: isTest)
            .map(ClubListResponse.self)
            .map { $0.toDomain() }
    }
    func fetchDetailClub(query: ClubRequestQuery, isTest: Bool) -> Single<Club> {
        request(.clubDetail(query: query), isTest: isTest)
            .map(DetailClubResponse.self)
            .map { $0.toDomain() }
    }
    func createNewClub(req: NewClubRequest, isTest: Bool) -> Completable {
        request(.createNewClub(req: req), isTest: isTest)
            .asCompletable()
    }
    func updateClub(query: ClubRequestQuery, req: NewClubRequest, isTest: Bool) -> Completable {
        request(.updateClub(query: query, req: req), isTest: isTest)
            .asCompletable()
    }
    func deleteClub(query: ClubRequestQuery, isTest: Bool) -> Completable {
        request(.deleteClub(query: query), isTest: isTest)
            .asCompletable()
    }
    func fetchClubMember(query: ClubRequestQuery, isTest: Bool) -> Single<[User]> {
        request(.clubMember(query: query), isTest: isTest)
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }
    func fetchClubApplicant(query: ClubRequestQuery, isTest: Bool) -> Single<[User]> {
        request(.clubApplicant(query: query), isTest: isTest)
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }
    func userAccept(query: ClubRequestQuery, userId: String, isTest: Bool) -> Completable {
        request(.userAccept(query: query, userId: userId), isTest: isTest)
            .asCompletable()
    }
    func userReject(query: ClubRequestQuery, userId: String, isTest: Bool) -> Completable {
        request(.userReject(query: query, userId: userId), isTest: isTest)
            .asCompletable()
    }
    func clubOpen(query: ClubRequestQuery, isTest: Bool) -> Completable {
        request(.clubOpen(query: query), isTest: isTest)
            .asCompletable()
    }
    func clubClose(query: ClubRequestQuery, isTest: Bool) -> Completable {
        request(.clubClose(query: query), isTest: isTest)
            .asCompletable()
    }
    func userKick(query: ClubRequestQuery, userId: String, isTest: Bool) -> Completable {
        request(.userKick(query: query, userId: userId), isTest: isTest)
            .asCompletable()
    }
}
