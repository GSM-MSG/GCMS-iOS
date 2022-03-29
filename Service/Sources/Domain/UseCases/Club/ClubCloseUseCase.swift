import RxSwift

public final class ClubCloseUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    func execute(query: ClubRequestQuery) -> Completable{
        clubRepository.clubClose(query: query)
    }
}
