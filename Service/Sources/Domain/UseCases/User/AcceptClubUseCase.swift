import RxSwift

public final class AcceptClubUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    public func execute(clubId: Int, isTest: Bool = false) -> Completable {
        repository.acceptClub(clubId: clubId, isTest: isTest)
    }
}
