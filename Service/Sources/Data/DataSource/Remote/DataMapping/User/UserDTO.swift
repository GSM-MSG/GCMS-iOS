import Foundation

struct UserDTO: Codable {
    let email: String
    let name: String
    let grade: Int
    let `class`: Int
    let num: Int
    let userImg: String?
}

extension UserDTO {
    func toDomain() -> User {
        return .init(
            userId: email,
            profileImageUrl: userImg,
            name: name,
            grade: grade,
            class: `class`,
            number: num
        )
    }
}
