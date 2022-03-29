import RxSwift

public final class UpdateClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        query: ClubRequestQuery,
        req: NewClubRequest
    ) -> Completable{
        clubRepository.updateClub(query: query, req: req)
    }
}
