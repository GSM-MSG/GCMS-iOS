import RxSwift

public final class AcceptClubUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(clubId: Int, isTest: Bool = false) -> Completable {
        repository.acceptClub(clubId: clubId, isTest: isTest)
    }
}
