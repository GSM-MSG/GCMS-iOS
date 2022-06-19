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
}
