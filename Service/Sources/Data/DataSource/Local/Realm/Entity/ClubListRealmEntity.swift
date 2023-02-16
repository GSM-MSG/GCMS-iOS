import RealmSwift
import Foundation

final class ClubListRealmEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var type: String = ""
    @Persisted var name: String = ""
    @Persisted var content: String = ""
    @Persisted var bannerImg: String = ""
}

extension ClubListRealmEntity {
    func setup(clubList: ClubList) {
        self.id = clubList.id
        self.name = clubList.name
        self.type = clubList.type.rawValue
        self.content = clubList.content
        self.bannerImg = clubList.bannerImg
    }
}

extension ClubListRealmEntity {
    func toDomain() -> ClubList {
        return .init(
            id: id,
            type: ClubType(rawValue: type) ?? .major,
            name: name,
            content: content,
            bannerImg: bannerImg
        )
    }
}
