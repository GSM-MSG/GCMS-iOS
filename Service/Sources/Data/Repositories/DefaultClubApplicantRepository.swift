import RxSwift
import Foundation

final class DefaultClubApplicantRepository: ClubApplicantRepository {
    
    private let clubApplicantRemote = ClubApplicantRemote.shared
    
    func fetchClubApplicant(clubID: String) -> Single<[User]> {
        clubApplicantRemote.fetchClubApplicant(clubID: clubID)
    }
    func apply() -> Single<[User]> {
        clubApplicantRemote.apply()
    }
    func userAccept(clubID: String, uuid: UUID) -> Completable {
        clubApplicantRemote.userAccept(clubID: clubID, uuid: uuid)
    }
    func userReject(clubID: String, uuid: UUID) -> Completable {
        clubApplicantRemote.userReject(clubID: clubID, uuid: uuid)
    }
}
