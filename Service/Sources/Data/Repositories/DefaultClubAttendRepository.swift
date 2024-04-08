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

    func createAttendance(clubID: Int, name: String, date: String, period: [Period]) -> Completable {
        clubAttendRemote.createAttendance(clubID: clubID, name: name, date: date, period: period)
    }

    func changeAttendStatus(attendanceId: String, attendanceStatus: AttendanceStatus) -> Completable {
        clubAttendRemote.changeAttendStatus(attendanceId: attendanceId, attendanceStatus: attendanceStatus)
    }

    func changeAllAttendStatus(attendanceIds: [String], attendanceStatus: AttendanceStatus) -> Completable {
        clubAttendRemote.changeAllAttendStatus(attendanceIds: attendanceIds, attendanceStatus: attendanceStatus)
    }
}
