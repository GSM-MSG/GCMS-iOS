import Foundation
import RxSwift

public protocol ClubAttendRepository {
    func fetchAttendList(clubID: Int, date: String?, period: Period?) -> Single<[ClubAttend]>
    func attendanceCreate(clubID: Int) -> Single<[ClubAttend]>
    func recordExcelPrint() -> Completable
    func changeAttendStatus() -> Completable
    func statusAllApply() -> Completable
}
