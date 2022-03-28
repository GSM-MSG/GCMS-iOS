import RxSwift

public final class UserRejectUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, userId: String) -> Completable{
        clubRepository.userReject(query: query, userId: userId)
    }
}
