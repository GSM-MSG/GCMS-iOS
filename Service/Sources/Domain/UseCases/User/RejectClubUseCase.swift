import RxSwift

public final class RejectClubUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(clubId: Int, isTest: Bool = false) -> Completable {
        repository.rejectClub(clubId: clubId, isTest: isTest)
    }
}
