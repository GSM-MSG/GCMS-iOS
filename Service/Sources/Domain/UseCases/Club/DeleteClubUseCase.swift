import RxSwift

public final class DeleteClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, isTest: Bool = false) -> Completable{
        clubRepository.deleteClub(query: query, isTest: isTest)
    }
}