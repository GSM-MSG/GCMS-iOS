import Foundation
import RealmSwift
import RxSwift

protocol ObjectPropertyUpdatable {}
extension ObjectPropertyUpdatable where Self: Object {
    func update(_ block: (Self) throws -> Void) rethrows {
        try? self.realm?.safeWrite {
            try? block(self)
        }
    }
}
extension Object: ObjectPropertyUpdatable {}

protocol RealmTaskType: AnyObject {
    func fetchObjects<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>?,
        sortProperty: String?,
        ordering: OrderingType
    ) -> Single<[T]>

    func add(_ object: Object?)
    func add(_ objects: [Object]?)
    func set(_ object: Object?)
    func set(_ objects: [Object]?)
    func delete(_ object: Object?)
    func delete(_ objects: [Object]?)
}

final class RealmTask: RealmTaskType {

    static let shared = RealmTask()

    private let realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public init() {
        let realmConfiguration = RealmTask.migration()
        guard let realm = try? Realm(configuration: realmConfiguration) else { fatalError() }
        self.realm = realm
    }

    func fetchObjects<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>? = nil,
        sortProperty: String? = nil,
        ordering: OrderingType = .ascending
    ) -> Single<[T]> {
        .create { single in
            let res = self.fetchObjectsResults(
                for: T.self,
                filter: filter,
                sortProperty: sortProperty,
                ordering: ordering
            ).toArray()

            single(.success(res))
            return Disposables.create()
        }
    }

    func fetchObjectsResults<T: Object>(
        for type: T.Type,
        filter: QueryFilter<T>? = nil,
        sortProperty: String? = nil,
        ordering: OrderingType = .ascending
    ) -> Results<T> {
        var res = realm.objects(T.self)
        if let filter = filter {
            switch filter {
            case let .string(query):
                res = res.filter(query)
            case let .predicate(query):
                res = res.filter(query)
            case let .where(query):
                res = res.where(query)
            }
        }
        if let sortProperty = sortProperty {
            res = res.sorted(byKeyPath: sortProperty, ascending: ordering == .ascending)
        }
        return res
    }

    func add(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object)
        }
    }

    func add(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.add(objects)
        }
    }

    func set(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object, update: .all)
        }
    }

    func set(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.add(objects, update: .all)
        }
    }

    func delete(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.delete(object)
        }
    }

    func delete(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.delete(objects)
        }
    }

    func deleteAll() {
        try? realm.safeWrite {
            realm.deleteAll()
        }
    }
}

private extension RealmTask {
    static func migration() -> Realm.Configuration {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, prevSchemaVersion in
                if prevSchemaVersion < 2 {
                    var pkID = 1
                    migration.enumerateObjects(ofType: ClubListRealmEntity.className()) { oldObject, newObject in
                        newObject?["id"] = pkID
                        pkID += 1
                        newObject?["bannerImg"] = oldObject?["bannerUrl"]
                        newObject?["name"] = oldObject?["title"]
                        newObject?["content"] = ""
                    }
                }
            }
        )

        return config
    }
}
