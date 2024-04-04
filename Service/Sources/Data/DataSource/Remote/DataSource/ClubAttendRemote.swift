import RxSwift
import Foundation

protocol ClubAttendRemoteProtocol {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func createAttendance(clubID: Int) -> Completable
    func changeAllAttendStatus() -> Completable
    func statusAllApply() -> Completable
}

final class ClubAttendRemote: BaseRemote<ClubAttendAPI>, ClubAttendRemoteProtocol {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]> {
        self.request(.fetchAttendList(clubID: clubID, date: date, period: period))
            .map(FetchClubAttendListResponse.self)
            .map { $0.toDomain() }
    }

    func createAttendance(clubID: Int) -> Completable {
        self.request(.createAttendance(clubID: clubID))
            .asCompletable()
    }

    func changeAllAttendStatus() -> Completable {
        self.request(.changeAllAttendStatus)
            .asCompletable()
    }

    func statusAllApply() -> Completable {
        self.request(.statusAllApply)
            .asCompletable()
    }
}
