import RxSwift

public final class ClubExitUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    private let userRepository: UserRepository
    
    public func execute(query: ClubRequestQuery) -> Completable {
        userRepository.clubExit(query: query)
    }
}
