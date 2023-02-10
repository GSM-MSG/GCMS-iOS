import RxSwift
import Foundation

final class DefaultClubApplicantRepository: ClubApplicantRepository {
    
    private let clubApplicantRemote = ClubApplicantRemote.shared
    
    func fetchClubApplicant(clubID: String) -> Single<[Member]> {
        clubApplicantRemote.fetchClubApplicant(clubID: clubID)
    }
    func apply(clubID: String) -> Single<[Member]> {
        clubApplicantRemote.apply(clubID: clubID)
    }
    func userAccept(clubID: String, uuid: UUID) -> Completable {
        clubApplicantRemote.userAccept(clubID: clubID, uuid: uuid)
    }
    func userReject(clubID: String, uuid: UUID) -> Completable {
        clubApplicantRemote.userReject(clubID: clubID, uuid: uuid)
    }
}
