import RxSwift

public final class CreateNewClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(req: NewClubRequest) -> Completable{
        clubRepository.createNewClub(req: req)
    }
}
