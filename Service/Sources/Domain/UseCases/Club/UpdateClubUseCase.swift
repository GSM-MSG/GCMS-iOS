import RxSwift

public struct UpdateClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(clubID: Int, req: UpdateClubRequest) -> Completable{
        clubRepository.updateClub(clubID: clubID, req: req)
    }
}
