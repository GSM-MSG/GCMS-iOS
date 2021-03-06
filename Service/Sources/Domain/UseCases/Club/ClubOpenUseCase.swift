import RxSwift

public struct ClubOpenUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery) -> Completable{
        clubRepository.clubOpen(query: query)
    }
}
