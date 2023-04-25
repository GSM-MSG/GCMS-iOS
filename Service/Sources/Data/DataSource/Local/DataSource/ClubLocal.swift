import RxSwift
import Then

protocol ClubLocalProtocol {
    func fetchClubList(type: ClubType) -> Single<[ClubList]>
    func saveClubList(clubList: [ClubList])
    func deleteClubList()
}

final class ClubLocal: ClubLocalProtocol {
    private let realm: any RealmTaskType

    public init(realmTask: RealmTaskType) {
        self.realm = realmTask
    }

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
