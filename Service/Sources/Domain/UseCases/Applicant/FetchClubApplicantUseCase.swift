import RxSwift
import Foundation

public struct FetchClubApplicantUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute(clubID: String) -> Single<[User]>{
        clubApplicantRepository.fetchClubApplicant(clubID: clubID)
    }
}
