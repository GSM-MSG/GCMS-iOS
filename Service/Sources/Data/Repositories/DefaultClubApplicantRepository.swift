import RxSwift
import Foundation

final class DefaultClubApplicantRepository: ClubApplicantRepository {
    private let clubApplicantRemote = ClubApplicantRemote.shared

    func fetchClubApplicant(clubID: Int) -> Single<(MemberScope, [User])> {
        clubApplicantRemote.fetchClubApplicant(clubID: clubID)
    }

    func apply(clubID: Int) -> Completable {
        clubApplicantRemote.apply(clubID: clubID)
    }

    func cancel(clubID: Int) -> Completable {
        clubApplicantRemote.cancel(clubID: clubID)
    }

    func userAccept(clubID: Int, uuid: UUID) -> Completable {
        clubApplicantRemote.userAccept(clubID: clubID, uuid: uuid)
    }

    func userReject(clubID: Int, uuid: UUID) -> Completable {
        clubApplicantRemote.userReject(clubID: clubID, uuid: uuid)
    }
}
