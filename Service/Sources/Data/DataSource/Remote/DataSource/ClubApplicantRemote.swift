import RxSwift
import Foundation

protocol ClubApplicantRemoteProtocol {
    func fetchClubApplicant(clubID: Int) -> Single<(MemberScope, [User])>
    func apply(clubID: Int) -> Completable
    func cancel(clubID: Int) -> Completable
    func userAccept(clubID: Int, uuid: UUID) -> Completable
    func userReject(clubID: Int, uuid: UUID) -> Completable
}

final class ClubApplicantRemote: BaseRemote<ClubApplicantAPI>, ClubApplicantRemoteProtocol {
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
