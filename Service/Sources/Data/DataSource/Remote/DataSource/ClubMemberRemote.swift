import RxSwift
import Foundation

final class ClubMemberRemote: BaseRemote<ClubMemberAPI> {
    static let shared = ClubMemberRemote()
    private override init() {}
    
    func fetchClubMember(clubID: String) -> Single<[Member]> {
        request(.clubMember(clubID: clubID))
            .map(ClubMemberResponse.self)
            .map { $0.toDomain() }
    }
    func userKick(clubID: String, uuid: UUID) -> Completable {
        request(.userKick(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
    func delegation(clubID: String, uuid: UUID) -> Completable {
        request(.delegation(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
}
