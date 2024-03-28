import Foundation
import RxSwift

final class DefaultClubAttendRepository: ClubAttendRepository {
    private let clubAttendRemote: any ClubAttendRemoteProtocol

    init(clubAttendRemote: any ClubAttendRemoteProtocol) {
        self.clubAttendRemote = clubAttendRemote
    }

    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]> {
        clubAttendRemote.fetchAttendList(clubID: clubID, date: date, period: period)
    }

    func attendanceCreate(clubID: Int) -> Completable {
        clubAttendRemote.attendanceCreate(clubID: clubID)
    }

    func recordExcelPrint() -> Completable {
        clubAttendRemote.recordeExcelPrint()
    }

    func changeAttendStatus() -> Completable {
        clubAttendRemote.changeAttendStatus()
    }

    func statusAllApply() -> Completable {
        clubAttendRemote.statusAllApply()
    }
}
