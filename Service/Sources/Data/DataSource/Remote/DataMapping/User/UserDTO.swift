import Foundation

struct UserDTO: Codable {
    let uuid: UUID
    let email: String
    let name: String
    let grade: Int
    let classNum: Int
    let number: Int
    let profileImg: String?
}

extension UserDTO {
    func toDomain() -> User {
        return .init(uuid: uuid,
                     email: email,
                     name: name,
                     grade: grade,
                     classNum: classNum,
                     number: number,
                     profileImg: profileImg ?? "")
    }
}
