import RxSwift

public final class FetchClubLiseUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(type: ClubType) -> Single<[ClubList]> {
        clubRepository.fetchClubList(type: type)
    }
}
