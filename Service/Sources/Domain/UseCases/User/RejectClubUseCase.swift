import RxSwift

public final class RejectClubUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        repository.rejectClub(name: name, type: type, isTest: isTest)
    }
}
