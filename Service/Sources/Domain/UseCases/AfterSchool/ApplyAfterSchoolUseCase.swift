import RxSwift

public struct ApplyAfterSchoolUseCase {
    public init(afterSchoolRepository: AfterSchoolRepository) {
        self.afterSchoolRepository = afterSchoolRepository
    }
    
    private let afterSchoolRepository: AfterSchoolRepository
    
    public func execute(id: Int) -> Completable {
        afterSchoolRepository.applyAfterSchool(id: id)
    }
}
