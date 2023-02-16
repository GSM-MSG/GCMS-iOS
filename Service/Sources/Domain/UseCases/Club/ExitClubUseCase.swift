import RxSwift

public struct ExitClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(clubID: Int) -> Completable{
        clubRepository.exitClub(clubID: clubID)
    }
}
