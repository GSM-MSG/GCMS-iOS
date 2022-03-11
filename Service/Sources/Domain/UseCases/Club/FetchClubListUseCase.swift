import RxSwift

public final class FetchClubListUseCase {
    internal init(repository: ClubRepository) {
        self.repository = repository
    }
    
    private let repository: ClubRepository
    
    func execute(type: ClubType, isTest: Bool = false) -> Single<[ClubList]> {
        return repository.fetchClubList(type: type, isTest: isTest)
    }
}
