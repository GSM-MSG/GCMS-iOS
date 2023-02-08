import RxSwift
import Foundation

final class DefaultClubMemberRepository: ClubMemberRepository {
    private let clubMemberRemote = ClubMemberRemote.shared
    
    func fetchClubMember(clubID: String) -> Single<[Member]> {
        clubMemberRemote.fetchClubMember(clubID: clubID)
    }
    func userKick(clubID: String, uuid: UUID) -> Completable {
        clubMemberRemote.userKick(clubID: clubID, uuid: uuid)
    }
    func delegation(clubID: String, uuid: UUID) -> Completable {
        clubMemberRemote.delegation(clubID: clubID, uuid: uuid)
    }
}
