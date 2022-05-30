import RxSwift

final class AfterSchoolRemote: BaseRemote<AfterSchoolAPI> {
    static let shared = AfterSchoolRemote()
    private override init() {}

    func fetchAfterSchoolList(query: AfterSchoolQuery) -> Single<[AfterSchool]> {
        request(.afterSchoolList(query: query))
            .map([AfterSchoolListResponse].self)
            .map { $0.map { $0.toDomain() } }
    }

    func applyAfterSchool(id: Int) -> Completable {
        request(.apply(afterSchoolId: id))
            .asCompletable()
    }
    
    func cancelAfterSchool(id: Int) -> Completable {
        request(.cancel(afterSchoolId: id))
            .asCompletable()
    }
    
    func fetchFindAfterSchool(name: String, query: AfterSchoolQuery) -> Single<[AfterSchool]> {
        request(.find(name: name, query: query))
            .map([AfterSchoolListResponse].self)
            .map { $0.map { $0.toDomain() } }
    }
}
