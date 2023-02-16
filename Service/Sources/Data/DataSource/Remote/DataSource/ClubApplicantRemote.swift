import RxSwift
import Foundation

final class ClubApplicantRemote: BaseRemote<ClubApplicantAPI>{
    
    static let shared = ClubApplicantRemote()
    private override init() {}
    
    func fetchClubApplicant(clubID: Int) -> Single<[User]> {
        request(.applicantList(clubID: clubID))
            .map(ClubApplicantResponse.self)
            .map { $0.toDomain() }
    }
    
    func apply() -> Completable {
        request(.apply)
            .asCompletable()
    }
    
    func cancel() -> Completable {
        request(.cancel)
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
