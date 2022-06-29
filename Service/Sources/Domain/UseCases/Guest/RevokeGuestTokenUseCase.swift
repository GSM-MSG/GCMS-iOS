import RxSwift

public struct RevokeGuestTokenUseCase {
    public init(guestRepository: GuestRepository) {
        self.guestRepository = guestRepository
    }
    
    private let guestRepository: GuestRepository
    
    public func execute() -> Completable {
        guestRepository.revokeGuestToken()
    }
}
