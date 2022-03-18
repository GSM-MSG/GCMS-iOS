import RxSwift

public final class FetchClubLiseUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(type: ClubType, isTest: Bool = false) -> Single<[ClubList]> {
        clubRepository.fetchClubList(type: type, isTest: isTest)
    }
}
