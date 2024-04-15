import Foundation
import RxSwift

public protocol ClubAttendRepository {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func createAttendance(clubID: Int, name: String, date: String, period: [Period]) -> Completable
    func changeAttendStatus(attendanceId: String, attendanceStatus: AttendanceStatus) -> Completable
    func changeAllAttendStatus(attendanceIds: [String], attendanceStatus: AttendanceStatus) -> Completable
}
