import RxSwift

public final class FetchNoticeListUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    func execute(isTest: Bool = false) -> Single<[Notice]> {
        return repository.fetchNoticeList(isTest: isTest)
    }
}
