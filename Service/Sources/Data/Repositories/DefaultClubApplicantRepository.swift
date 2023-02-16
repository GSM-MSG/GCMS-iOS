import RxSwift
import Foundation

final class DefaultClubApplicantRepository: ClubApplicantRepository {
    
    private let clubApplicantRemote = ClubApplicantRemote.shared
    
    func fetchClubApplicant(clubID: Int) -> Single<[User]> {
        clubApplicantRemote.fetchClubApplicant(clubID: clubID)
    }
    func apply() -> Completable {
        clubApplicantRemote.apply()
    }
    func cancel() -> Completable {
        clubApplicantRemote.cancel()
    }
    func userAccept(clubID: Int, uuid: UUID) -> Completable {
        clubApplicantRemote.userAccept(clubID: clubID, uuid: uuid)
    }
    func userReject(clubID: Int, uuid: UUID) -> Completable {
        clubApplicantRemote.userReject(clubID: clubID, uuid: uuid)
    }
}
