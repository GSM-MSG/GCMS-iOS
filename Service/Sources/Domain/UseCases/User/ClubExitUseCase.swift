import RxSwift

public struct ClubExitUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    private let userRepository: UserRepository
    
    public func execute(query: ClubRequestQuery) -> Completable {
        userRepository.clubExit(query: query)
    }
}
