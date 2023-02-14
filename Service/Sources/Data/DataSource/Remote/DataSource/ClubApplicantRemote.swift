import RxSwift
import Foundation

final class ClubApplicantRemote: BaseRemote<ClubApplicantAPI>{
    
    static let shared = ClubApplicantRemote()
    private override init() {}
    
    func fetchClubApplicant(clubID: String) -> Single<[User]> {
        request(.applicantList(clubID: clubID))
            .map(ClubApplicantResponse.self)
            .map { $0.toDomain() }
    }
    
    func apply(clubID: String) -> Single<[User]> {
        request(.applicantList(clubID: clubID))
            .map(ClubApplicantResponse.self)
            .map { $0.toDomain() }
    }
    
    func userAccept(clubID: String, uuid: UUID) -> Completable {
        request(.userAccept(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
    
    func userReject(clubID: String, uuid: UUID) -> Completable {
        request(.userReject(clubID: clubID, uuid: uuid))
            .asCompletable()
    }
}
