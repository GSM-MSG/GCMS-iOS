import RxSwift
import Foundation

final class DefaultGuestRepository: GuestRepository {
    private let guestRemote = GuestRemote.shared
    private let clubLocal = ClubLocal.shared
    private let keychain = KeychainLocal.shared
    
    func fetchGuestClubList(type: ClubType) -> Observable<[ClubList]> {
        OfflineCache<[ClubList]>()
            .localData { self.clubLocal.fetchClubList(type: type) }
            .remoteData { self.guestRemote.fetchGuestClubList(type: type) }
            .doOnNeedRefresh { self.clubLocal.deleteClubList(); self.clubLocal.saveClubList(clubList: $0) }
            .createObservable()
    }
    func fetchGuestDetailClub(query: ClubRequestQuery) -> Single<Club> {
        guestRemote.fetchGuestDetailClub(query: query)
    }
    func issueGuestToken(idToken: String, code: String) -> Completable {
        guestRemote.fetchGuestRefreshToken(idToken: idToken, code: code)
            .asObservable()
            .do(onNext: { self.keychain.saveGuestRefreshToken($0) })
                .asSingle()
                .asCompletable()
    }
    func revokeGuestToken() -> Completable {
        do {
            return guestRemote.revokeGuestToken(refreshToken: try keychain.fetchGuestRefreshToken())
        } catch {
            return Completable.error(GCMSError.noInternet)
        }
    }
}
