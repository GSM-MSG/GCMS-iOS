import RxSwift

public struct ClubCloseUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(clubID: String) -> Completable{
        clubRepository.clubClose(clubID: clubID)
    }
}
