import RxSwift

public protocol AfterSchoolRepository {
    func fetchAfterSchoolList(query: AfterSchoolQuery) -> Single<[AfterSchool]>
    func applyAfterSchool(id: Int) -> Completable
    func cancelAfterSchool(id: Int) -> Completable
    func fetchFindAfterSchool(name: String, query: AfterSchoolQuery) -> Single<[AfterSchool]>
    
}
