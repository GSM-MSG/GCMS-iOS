import RxSwift

public final class ClubEndUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        clubRepository.clubEnd(name: name, type: type, isTest: isTest)
    }
}
