import RxSwift

public struct ExitClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func exitClub(clubID: String) -> Completable{
        clubRepository.exitClub(clubID: clubID)
    }
}
