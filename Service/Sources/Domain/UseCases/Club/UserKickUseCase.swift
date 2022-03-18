import RxSwift

public final class UserKickUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        query: ClubRequestComponent,
        userId: String,
        isTest: Bool = false
    ) -> Completable{
        clubRepository.userKick(query: query, userId: userId, isTest: isTest)
    }
}
