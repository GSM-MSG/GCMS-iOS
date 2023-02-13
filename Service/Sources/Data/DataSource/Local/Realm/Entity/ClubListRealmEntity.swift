import RealmSwift

final class ClubListRealmEntity: Object {
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var type: String = ""
    @Persisted var bannerImg: String = ""
}

extension ClubListRealmEntity {
    func setup(clubList: ClubList) {
        self.name = clubList.name
        self.type = clubList.type.rawValue
        self.bannerImg = clubList.bannerImg
    }
}

extension ClubListRealmEntity {
    func toDomain() -> ClubList {
        return .init(
            bannerImg: bannerImg,
            name: name,
            type: ClubType(rawValue: type) ?? .major
        )
    }
}
