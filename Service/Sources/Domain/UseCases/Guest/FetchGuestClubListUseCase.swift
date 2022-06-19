import RxSwift

public struct FetchGuestClubListUseCase {
    public init(guestRepository: GuestRepository) {
        self.guestRepository = guestRepository
    }
    
    private let guestRepository: GuestRepository
    
    public func execute(type: ClubType) -> Observable<[ClubList]> {
        guestRepository.fetchGuestClubList(type: type)
    }
}
