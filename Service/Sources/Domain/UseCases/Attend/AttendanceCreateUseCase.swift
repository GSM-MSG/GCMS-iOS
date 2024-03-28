import RxSwift
import Foundation

public struct AttendanceCreateUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }

    private let clubAttendRepository: ClubAttendRepository

    public func execute(clubID: Int) -> Single<[ClubAttend]> {
        clubAttendRepository.attendanceCreate(clubID: clubID)
    }
}
