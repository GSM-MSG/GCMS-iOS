import RxSwift

public final class UserAcceptUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, userId: String, isTest: Bool = false) -> Completable{
        clubRepository.userAccept(query: query, userId: userId, isTest: isTest)
    }
}
