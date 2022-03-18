import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    func fetchClubList(type: ClubType, isTest: Bool) -> Single<ClubListResponse> {
        request(.clubList(type: type), isTest: isTest)
            .map(ClubListResponse.self)
    }
    
}
