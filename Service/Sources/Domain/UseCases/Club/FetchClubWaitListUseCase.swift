import RxSwift

public final class FetchClubWaitListUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(name: String, type: ClubType, isTest: Bool = false) -> Single<[User]> {
        clubRepository.fetchClubWaitList(name: name, type: type, isTest: isTest)
    }
}
