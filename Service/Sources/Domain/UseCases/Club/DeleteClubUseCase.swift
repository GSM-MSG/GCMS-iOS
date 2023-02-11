import RxSwift

public struct DeleteClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(clubID: Int) -> Completable{
        clubRepository.deleteClub(clubID: clubID)
    }
}
