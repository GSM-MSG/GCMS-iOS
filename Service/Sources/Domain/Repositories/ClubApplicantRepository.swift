import RxSwift
import Foundation

public protocol ClubApplicantRepository {
    func fetchClubApplicant(clubID: Int) -> Single<(MemberScope, [User])>
    func apply(clubID: Int) -> Completable
    func cancel(clubID: Int) -> Completable
    func userAccept(clubID: Int, uuid: UUID) -> Completable
    func userReject(clubID: Int, uuid: UUID) -> Completable
}
