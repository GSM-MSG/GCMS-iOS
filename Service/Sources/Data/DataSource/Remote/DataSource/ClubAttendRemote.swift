import RxSwift
import Foundation

protocol ClubAttendRemoteProtocol {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func createAttendance(clubID: Int, name: String, date: String, period: [Period]) -> Completable
    func changeAllAttendStatus(attendanceID: String, attendanceStatus: AttendanceStatus) -> Completable
    func statusAllApply(attendanceIDs: [String], attendanceStatus: AttendanceStatus) -> Completable
}

final class ClubAttendRemote: BaseRemote<ClubAttendAPI>, ClubAttendRemoteProtocol {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]> {
        self.request(.fetchAttendList(clubID: clubID, date: date, period: period))
            .map(FetchClubAttendListResponse.self)
            .map { $0.toDomain() }
    }

    func createAttendance(clubID: Int, name: String, date: String, period: [Period]) -> Completable {
        self.request(.createAttendance(clubID: clubID, name: name, date: date, period: period))
            .asCompletable()
    }

    func changeAllAttendStatus(attendanceID: String, attendanceStatus: AttendanceStatus) -> Completable {
        self.request(.changeAllAttendStatus(attendanceID: attendanceID, attendanceStatus: attendanceStatus))
            .asCompletable()
    }

    func statusAllApply(attendanceIDs: [String], attendanceStatus: AttendanceStatus) -> Completable {
        self.request(.statusAllApply(attendanceIDs: attendanceIDs, attendanceStatus: attendanceStatus))
            .asCompletable()
    }
}
