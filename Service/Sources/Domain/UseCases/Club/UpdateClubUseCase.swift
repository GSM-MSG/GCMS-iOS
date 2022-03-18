import RxSwift

public final class UpdateClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        query: ClubRequestComponent,
        req: NewClubRequest,
        isTest: Bool = false
    ) -> Completable{
        clubRepository.updateClub(query: query, req: req, isTest: isTest)
    }
}
