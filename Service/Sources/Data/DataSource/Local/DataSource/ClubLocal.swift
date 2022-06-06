import RxSwift
import Then

final class ClubLocal {
    static let shared = ClubLocal()
    
    private let realm = RealmTask.shared
    
    private init() {}
    
    func fetchClubList(type: ClubType) -> Single<[ClubList]> {
        return realm.fetchObjects(
            for: ClubListRealmEntity.self,
            filter: .where(query: { entity in
                entity.type.equals(type.rawValue)
            })
        ).map { $0.map { $0.toDomain() } }
    }
    
    func saveClubList(clubList: [ClubList]) {
        let list = clubList.map { club in
            ClubListRealmEntity().then {
                $0.setup(clubList: club)
            }
        }
        realm.set(list)
    }
    
    func deleteClubList() {
        let list = realm.fetchObjectsResults(for: ClubListRealmEntity.self).toArray()
        realm.delete(list)
    }
}
