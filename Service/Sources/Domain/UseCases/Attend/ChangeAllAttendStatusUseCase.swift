import RxSwift
import Foundation

public struct ChangeAllAttendStatusUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }

    private let clubAttendRepository: ClubAttendRepository
    
    public func execute(
        attendanceIDs: [String],
        attendanceStatus: AttendanceStatus
    ) -> Completable {
        clubAttendRepository.changeAllAttendStatus(attendanceIDs: attendanceIDs, attendanceStatus: attendanceStatus)
    }
}
