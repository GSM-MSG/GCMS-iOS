import RxSwift

public final class FetchDetailClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery) -> Single<Club> {
        clubRepository.fetchDetailClub(query: query)
    }
}
