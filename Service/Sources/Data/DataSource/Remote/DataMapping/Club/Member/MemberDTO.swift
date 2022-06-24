import Foundation

struct MemberDTO: Codable {
    let email: String
    let name: String
    let grade: Int
    let `class`: Int
    let num: Int
    let userImg: String
    let scope: MemberScope
}

extension MemberDTO {
    func toDomain() -> Member {
        return .init(
            email: email,
            name: name,
            grade: grade,
            class: `class`,
            number: num,
            scope: scope,
            profileImageUrl: userImg
        )
    }
}
