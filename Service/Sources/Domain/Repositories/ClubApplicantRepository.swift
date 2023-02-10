import RxSwift
import Foundation

public protocol ClubApplicantRepository {
    func fetchClubApplicant(clubID: String) -> Single<[Member]>
    func apply(clubID: String) -> Single<[Member]>
    func userAccept(clubID: String, uuid: UUID) -> Completable
    func userReject(clubID: String, uuid: UUID) -> Completable
}
