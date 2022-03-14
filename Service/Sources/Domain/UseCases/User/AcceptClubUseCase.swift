import RxSwift

public final class AcceptClubUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        repository.acceptClub(name: name, type: type, isTest: isTest)
    }
}
