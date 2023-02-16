import RxSwift

public struct ExitClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func exitClub(clubID: Int) -> Completable{
        clubRepository.exitClub(clubID: clubID)
    }
}
