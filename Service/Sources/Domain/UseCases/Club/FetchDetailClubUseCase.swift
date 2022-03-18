import RxSwift

public final class FetchDetailClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestComponent, isTest: Bool = false) -> Single<Club> {
        clubRepository.fetchDetailClub(query: query, isTest: isTest)
    }
}
