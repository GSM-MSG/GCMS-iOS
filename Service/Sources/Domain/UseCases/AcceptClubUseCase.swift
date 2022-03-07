import RxSwift

public final class AcceptClubUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    func execute(clubId: Int, isTest: Bool = false) -> Completable {
        return repository.acceptClub(clubId: clubId, isTest: isTest)
    }
}
