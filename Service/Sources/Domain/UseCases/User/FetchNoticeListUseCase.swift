import RxSwift

public final class FetchNoticeListUseCase {
    public init(userRepository: UserRepository) {
        self.repository = userRepository
    }
    
    private let repository: UserRepository
    
    public func execute(isTest: Bool = false) -> Single<[Notice]> {
        repository.fetchNoticeList(isTest: isTest)
    }
}
