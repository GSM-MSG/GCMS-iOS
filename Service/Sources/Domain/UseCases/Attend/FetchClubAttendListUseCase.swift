import RxSwift
import Foundation

public struct ClubAttendCheckUseCase {
    public init(clubAttendRepository: ClubAttendRepository) {
        self.clubAttendRepository = clubAttendRepository
    }
    
    private let clubAttendRepository: ClubAttendRepository
    
    public func execute(clubID: Int) -> Completable {
        fetch
    }
}
