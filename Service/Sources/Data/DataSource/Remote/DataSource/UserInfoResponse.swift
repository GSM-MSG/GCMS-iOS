import RxSwift

struct UserInfoReesponse: Codable {
    let id: Int
    let name: String
    let picture: String
    let grade: Int
    let `class`: Int
    let number: Int
    let joinedMajorClub: Int?
    let joinedEditorialClub: [Int]?
    let joinedFreedomClub: Int?
}

extension UserInfoReesponse {
    func toDomain() -> User {
        return .init(
            id: self.id,
            picture: self.picture,
            name: self.name,
            grade: self.grade,
            class: self.class,
            number: self.number,
            joinedMajorClub: self.joinedMajorClub,
            joinedEditorialClub: self.joinedEditorialClub,
            joinedFreedomClub: self.joinedFreedomClub
        )
    }
}
