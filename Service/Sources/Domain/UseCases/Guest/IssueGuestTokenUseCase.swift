import RxSwift

public struct IssueGuestTokenUseCase {
    public init(guestRepository: GuestRepository) {
        self.guestRepository = guestRepository
    }
    
    private let guestRepository: GuestRepository
    
    public func execute(idToken: String, code: String) -> Completable {
        guestRepository.issueGuestToken(idToken: idToken, code: code)
    }
}
