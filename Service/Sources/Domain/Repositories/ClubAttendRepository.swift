import Foundation
import RxSwift

public protocol ClubAttendRepository {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func createAttendance(clubID: Int, name: String, date: String, period: [Period]) -> Completable
    func changeAllAttendStatus(attendanceID: String, attendanceStatus: AttendanceStatus) -> Completable
    func statusAllApply(attendanceIDs: [String], attendanceStatus: AttendanceStatus) -> Completable
}
