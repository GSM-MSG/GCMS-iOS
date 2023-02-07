import Foundation

struct MemberDTO: Codable {
    let uuid: UUID
    let email: String
    let name: String
    let grade: Int
    let classNum: Int
    let number: Int
    let profileImg: String?
    let scope: MemberScope
}

extension MemberDTO {
    func toDomain() -> Member {
        return .init(
            uuid: uuid,
            email: email,
            name: name,
            grade: grade,
            classNum: classNum,
            number: number,
            scope: scope,
            profileImg: profileImg
        )
    }
}
