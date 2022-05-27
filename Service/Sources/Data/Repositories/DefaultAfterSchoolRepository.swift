import RxSwift
import Foundation

final class DefaultAfterSchoolRepository: AfterSchoolRepository {
    func fetchAfterSchoolList(query: AfterSchoolQuery) -> Single<[AfterSchool]> {
        afterSchoolRemote.fetchAfterSchoolList(query: query)
    }
    
    func applyAfterSchool(id: Int) -> Completable {
        afterSchoolRemote.applyAfterSchool(id: id)
    }
    
    func cancelAfterSchool(id: Int) -> Completable {
        afterSchoolRemote.cancelAfterSchool(id: id)
    }
    
    func fetchFindAfterSchool(name: String, query: AfterSchoolQuery) -> Single<[AfterSchool]> {
        afterSchoolRemote.fetchFindAfterSchool(name: name, query: query)
    }
    
    private let afterSchoolRemote = AfterSchoolRemote.shared
}
