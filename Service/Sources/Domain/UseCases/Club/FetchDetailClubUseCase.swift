import RxSwift

public struct FetchDetailClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(clubID: String) -> Single<Club> {
        clubRepository.fetchDetailClub(clubID: clubID)
    }
}
