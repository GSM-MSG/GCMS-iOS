import RealmSwift

final class ClubListRealmEntity: Object {
    @Persisted(primaryKey: true) var title: String = ""
    @Persisted var type: String = ""
    @Persisted var bannerUrl: String = ""
}

extension ClubListRealmEntity {
    func setup(clubList: ClubList) {
        self.title = clubList.title
        self.type = clubList.type.rawValue
        self.bannerUrl = clubList.bannerUrl
    }
}

extension ClubListRealmEntity {
    func toDomain() -> ClubList {
        return .init(
            bannerUrl: bannerUrl,
            title: title,
            type: ClubType(rawValue: type) ?? .major
        )
    }
}
