import RxSwift

public struct UserAcceptUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, userId: String) -> Completable{
        clubRepository.userAccept(query: query, userId: userId)
    }
}
