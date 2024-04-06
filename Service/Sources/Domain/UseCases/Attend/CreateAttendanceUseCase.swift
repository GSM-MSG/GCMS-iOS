import RxSwift
import Foundation

public struct CreateAttendanceUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }

    private let clubAttendRepository: ClubAttendRepository

    public func execute(
        clubID: Int,
        name: String,
        date: String,
        period: [Period]
    ) -> Completable {
        clubAttendRepository.createAttendance(clubID: clubID, name: name, date: date, period: period)
    }
}
