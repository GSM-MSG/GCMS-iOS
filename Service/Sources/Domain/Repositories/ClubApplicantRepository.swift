import RxSwift
import Foundation

public protocol ClubApplicantRepository {
    func fetchClubApplicant(clubID: String) -> Single<[User]>
    func apply() -> Single<[User]>
    func userAccept(clubID: String, uuid: UUID) -> Completable
    func userReject(clubID: String, uuid: UUID) -> Completable
}
