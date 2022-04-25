import RxSwift

public final class UpdateClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        req: UpdateClubRequest
    ) -> Completable{
        clubRepository.updateClub(req: req)
    }
}
