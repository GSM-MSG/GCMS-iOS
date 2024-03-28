import RxSwift
import Foundation

public struct RecordExcelPrintUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }
    
    private let clubAttendRepository: ClubAttendRepository
    
    public func execute(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]> {
        clubAttendRepository.recordExcelPrint()
    }
}
