import Foundation

struct SingleUserResponse: Decodable {
    let uuid: UUID
    let email: String
    let name: String
    let grade: Int
    let classNum: Int
    let number: Int
    let profileImg: String?
}

extension SingleUserResponse {
    func toDomain() -> User {
        User(
            uuid: uuid,
            email: email,
            name: name,
            grade: grade,
            classNum: classNum,
            number: number,
            profileImg: profileImg
        )
    }
}
