import RxSwift

public final class FetchNoticeListUseCase {
    public init(repository: UserRepository) {
        self.repository = repository
    }
    
    private let repository: UserRepository
    
    public func execute(isTest: Bool = false) -> Single<[Notice]> {
        repository.fetchNoticeList(isTest: isTest)
    }
}
