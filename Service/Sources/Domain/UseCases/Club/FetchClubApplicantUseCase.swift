import RxSwift

public final class FetchClubApplicantUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestComponent, isTest: Bool = false) -> Single<[User]> {
        clubRepository.fetchClubApplicant(query: query, isTest: isTest)
    }
}
