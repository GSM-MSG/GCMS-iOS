import RxSwift

public struct FetchGuestDeatilClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery) -> Single<Club> {
        clubRepository.fetchGuestDetailClub(query: query)
    }
}
