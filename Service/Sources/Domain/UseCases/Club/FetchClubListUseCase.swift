import RxSwift

public final class FetchClubListUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(type: ClubType) -> Single<[ClubList]> {
        clubRepository.fetchClubList(type: type)
    }
}
