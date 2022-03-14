import RxSwift

public final class JoinClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        clubRepository.joinClub(name: name, type: type, isTest: isTest)
    }
}
