import RxSwift

public final class UserKickUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        query: ClubRequestQuery,
        userId: String
    ) -> Completable{
        clubRepository.userKick(query: query, userId: userId)
    }
}
