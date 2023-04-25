import RxSwift
import Foundation

protocol ClubMemberRemoteProtocol {
    func fetchClubMember(clubID: Int) -> Single<(MemberScope, [Member])>
    func userKick(clubID: Int, uuid: UUID) -> Completable
    func delegation(clubID: Int, uuid: UUID) -> Completable
}

final class ClubMemberRemote: BaseRemote<ClubMemberAPI>, ClubMemberRemoteProtocol {
    func fetchClubMember(clubID: Int) -> Single<(MemberScope, [Member])> {
        request(.clubMember(clubID: clubID))
            .map(FetchClubMemberResponse.self)
            .map { $0.toDomain() }
    }

    func userKick(clubID: Int, uuid: UUID) -> Completable {
        request(.userKick(clubID: clubID, uuid: uuid))
            .asCompletable()
    }

    func delegation(clubID: Int, uuid: UUID) -> Completable {
        request(.delegation(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
}
