import RxSwift
import Foundation

public final class FetchManagementClubUseCase {
    public init(repository: ClubRepository) {
        self.repository = repository
    }
    
    private let repository: ClubRepository
    
    public func execute(isTest: Bool = false) -> Single<[ClubList]> {
        repository.fetchManagementClub(isTest: isTest)
    }
}
