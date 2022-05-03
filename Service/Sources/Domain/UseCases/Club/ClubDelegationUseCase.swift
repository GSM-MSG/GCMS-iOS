import RxSwift

public struct ClubDelegationUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, userId: String) -> Completable {
        clubRepository.delegation(query: query, userId: userId)
    }
}
