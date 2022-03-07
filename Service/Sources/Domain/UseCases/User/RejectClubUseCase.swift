import RxSwift

public final class RejectClubUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    public func execute(clubId: Int, isTest: Bool = false) -> Completable {
        return repository.rejectClub(clubId: clubId, isTest: isTest)
    }
}
