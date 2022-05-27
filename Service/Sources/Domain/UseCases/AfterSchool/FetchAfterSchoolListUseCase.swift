import RxSwift

public struct FetchAfterSchoolListUseCase {
    public init(afterSchoolRepository: AfterSchoolRepository) {
        self.afterSchoolRepository = afterSchoolRepository
    }
    
    private let afterSchoolRepository: AfterSchoolRepository
    
    public func execute(query: AfterSchoolQuery) -> Single<[AfterSchool]> {
        afterSchoolRepository.fetchAfterSchoolList(query: query)
    }
}
