import RxSwift

public struct CancelAfterSchoolUseCase {
    public init(afterSchoolRepository: AfterSchoolRepository) {
        self.afterSchoolRepository = afterSchoolRepository
    }
    
    private let afterSchoolRepository: AfterSchoolRepository
    
    public func execute(id: Int) -> Completable {
        afterSchoolRepository.cancelAfterSchool(id: id)
    }
}
