import RxSwift
import Foundation

public protocol ClubMemberRepository {
    func fetchClubMember(clubID: String) -> Single<[Member]>
    func userKick(clubID: String, uuid: UUID) -> Completable
    func delegation(clubID: String, uuid: UUID) -> Completable
}
