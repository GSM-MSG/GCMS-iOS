import RxSwift

public struct FetchGuestClubListUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(type: ClubType) -> Observable<[ClubList]> {
        clubRepository.fetchGuestClubList(type: type)
    }
}
