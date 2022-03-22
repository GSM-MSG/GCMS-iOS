import RxSwift

public final class ClubOpenUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, isTest: Bool = false) -> Completable{
        clubRepository.clubOpen(query: query, isTest: isTest)
    }
}
