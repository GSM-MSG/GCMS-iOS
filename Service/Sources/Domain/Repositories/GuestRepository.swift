import RxSwift
import Foundation

public protocol GuestRepository {
    func fetchGuestClubList(type: ClubType) -> Observable<[ClubList]>
    func fetchGuestDetailClub(query: ClubRequestQuery) -> Single<Club>
}
