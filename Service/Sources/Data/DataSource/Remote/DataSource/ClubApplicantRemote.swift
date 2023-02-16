import RxSwift
import Foundation

final class ClubApplicantRemote: BaseRemote<ClubApplicantAPI>{
    
    static let shared = ClubApplicantRemote()
    private override init() {}
    
    func fetchClubApplicant(clubID: Int) -> Single<(MemberScope, [User])> {
        request(.applicantList(clubID: clubID))
            .map(FetchClubApplicantResponse.self)
            .map { $0.toDomain() }
    }
    
    func apply(clubID: Int) -> Completable {
        request(.apply(clubID: clubID))
            .asCompletable()
    }
    
    func cancel(clubID: Int) -> Completable {
        request(.cancel(clubID: clubID))
            .asCompletable()
    }
    
    func userAccept(clubID: Int, uuid: UUID) -> Completable {
        request(.userAccept(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
    
    func userReject(clubID: Int, uuid: UUID) -> Completable {
        request(.userReject(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
}
