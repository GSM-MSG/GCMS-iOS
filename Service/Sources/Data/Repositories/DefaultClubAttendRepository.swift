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

    func changeAttendStatus(attendanceID: String, attendanceStatus: AttendanceStatus) -> Completable {
        clubAttendRemote.changeAttendStatus(attendanceID: attendanceID, attendanceStatus: attendanceStatus)
    }

    func changeAllAttendStatus(attendanceIDs: [String], attendanceStatus: AttendanceStatus) -> Completable {
        clubAttendRemote.changeAllAttendStatus(attendanceIDs: attendanceIDs, attendanceStatus: attendanceStatus)
    }
}
