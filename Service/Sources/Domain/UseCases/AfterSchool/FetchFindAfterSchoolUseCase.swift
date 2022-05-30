import RxSwift

public struct FetchFindAfterSchoolUseCase {
    public init(afterSchoolRepository: AfterSchoolRepository) {
        self.afterSchoolRepository = afterSchoolRepository
    }
    
    private let afterSchoolRepository: AfterSchoolRepository
    
    public func execute(name: String, query: AfterSchoolQuery) -> Single<[AfterSchool]> {
        afterSchoolRepository.fetchFindAfterSchool(name: name, query: query)
    }
}
