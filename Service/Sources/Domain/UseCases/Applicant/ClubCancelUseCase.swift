import RxSwift

public struct ClubCancelUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery) -> Completable {
        clubRepository.cancel(query: query)
    }
}
