import Foundation
import RxSwift

public protocol ClubAttendRepository {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func createAttendance(clubID: Int) -> Completable
    func changeAttendStatus() -> Completable
    func statusAllApply() -> Completable
}
