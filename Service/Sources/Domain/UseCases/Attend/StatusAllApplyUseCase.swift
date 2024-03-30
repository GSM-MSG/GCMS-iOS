import RxSwift
import Foundation

public struct StatusAllApplyUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }

    private let clubAttendRepository: ClubAttendRepository

    public func execute() -> Completable {
        clubAttendRepository.statusAllApply()
    }
}