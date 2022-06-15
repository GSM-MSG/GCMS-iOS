import RxSwift

public struct FetchGuestDeatilClubUseCase {
    public init(guestRepository: GuestRepository) {
        self.guestRepository = guestRepository
    }
    
    private let guestRepository: GuestRepository
    
    public func execute(query: ClubRequestQuery) -> Single<Club> {
        guestRepository.fetchGuestDetailClub(query: query)
    }
}
