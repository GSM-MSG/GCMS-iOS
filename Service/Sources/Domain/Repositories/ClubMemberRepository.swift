import RxSwift
import Foundation

public protocol ClubMemberRepository {
    func fetchClubMember(clubID: Int) -> Single<[Member]>
    func userKick(clubID: Int, uuid: UUID) -> Completable
    func delegation(clubID: Int, uuid: UUID) -> Completable
}
