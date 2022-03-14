import RxSwift


public final class UserAcceptUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        userId: Int,
        name: String,
        type: ClubType,
        isTest: Bool = false
    ) -> Completable {
        clubRepository.userAccept(userId: userId, name: name, type: type, isTest: isTest)
    }
}
