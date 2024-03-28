import RxSwift
import Foundation

protocol ClubAttendRemoteProtocol {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func attendanceCreate(clubID: Int) -> Completable
    func recordeExcelPrint() -> Completable
    func changeAttendStatus() -> Completable
    func statusAllApply() -> Completable
}

final class ClubAttendRemote: BaseRemote<ClubAttendAPI>, ClubAttendRemoteProtocol {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]> {
        self.request(.fetchAttendList(clubID: clubID, date: date, period: period))
            .map(FetchClubAttendListResponse.self)
            .map { $0.toDomain() }
    }

    func attendanceCreate(clubID: Int) -> Completable {
        self.request(.attendanceCreate(clubID: clubID))
            .asCompletable()
    }

    func recordeExcelPrint() -> Completable{
        self.request(.recordeExcelPrint)
            .asCompletable()
    }

    func changeAttendStatus() -> Completable {
        self.request(.changeAttendStatus)
            .asCompletable()
    }

    func statusAllApply() -> Completable {
        self.request(.statusAllApply)
            .asCompletable()
    }
}
