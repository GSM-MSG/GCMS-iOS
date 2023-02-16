import RxSwift
import Foundation

public protocol ClubApplicantRepository {
    func fetchClubApplicant(clubID: Int) -> Single<[User]>
    func apply() -> Completable
    func cancel() -> Completable
    func userAccept(clubID: Int, uuid: UUID) -> Completable
    func userReject(clubID: Int, uuid: UUID) -> Completable
}
