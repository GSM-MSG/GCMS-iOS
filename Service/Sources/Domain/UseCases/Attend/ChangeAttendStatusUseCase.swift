import RxSwift
import Foundation

public struct ChangeAttendStatusUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }

    private let clubAttendRepository: ClubAttendRepository

    public func execute(attendanceId: String, attendanceStatus: AttendanceStatus) -> Completable {
        clubAttendRepository.changeAttendStatus(attendanceId: attendanceId, attendanceStatus: attendanceStatus)
    }
}
