import RxSwift

public final class CreateNewClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(req: NewClubRequest, isTest: Bool = false) -> Completable{
        clubRepository.createNewClub(req: req, isTest: isTest)
    }
}
