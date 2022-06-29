import RxSwift

final class GuestRemote: BaseRemote<GuestAPI> {
    static let shared = GuestRemote()
    private override init() {}
    
    func fetchGuestClubList(type: ClubType) -> Single<[ClubList]> {
        request(.guestClubList(type: type))
            .map([ClubListDTO].self)
            .map { $0.map { $0.toDomain() } }
    }
    func fetchGuestDetailClub(query: ClubRequestQuery) -> Single<Club> {
        request(.guestClubDetail(query: query))
            .map(DetailClubResponse.self)
            .map { $0.toDomain() }
    }
    func fetchGuestRefreshToken(idToken: String, code: String) -> Single<String> {
        request(.tokenIssue(idToken: idToken, code: code))
            .map(GuestRefreshTokenResponse.self)
            .map(\.refreshToken)
    }
    func revokeGuestToken(refreshToken: String) -> Completable {
        request(.tokenRevoke(refreshToken: refreshToken))
            .asCompletable()
    }
}
