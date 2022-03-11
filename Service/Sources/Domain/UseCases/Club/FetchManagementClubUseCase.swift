import RxSwift
import Foundation

public final class FetchManagementClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.repository = clubRepository
    }
    
    private let repository: ClubRepository
    
    public func execute(isTest: Bool = false) -> Single<[ClubList]> {
        repository.fetchManagementClub(isTest: isTest)
    }
}
