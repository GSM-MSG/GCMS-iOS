import RxSwift
import Foundation

final class DefaultClubMemberRepository: ClubMemberRepository {
    private let clubMemberRemote = ClubMemberRemote.shared

    func fetchClubMember(clubID: Int) -> Single<(MemberScope, [Member])> {
        clubMemberRemote.fetchClubMember(clubID: clubID)
    }

    func userKick(clubID: Int, uuid: UUID) -> Completable {
        clubMemberRemote.userKick(clubID: clubID, uuid: uuid)
    }

    func delegation(clubID: Int, uuid: UUID) -> Completable {
        clubMemberRemote.delegation(clubID: clubID, uuid: uuid)
    }
}
