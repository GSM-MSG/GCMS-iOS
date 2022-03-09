struct UserDTO: Codable {
    let id: Int
    let name: String
    let picture: String
    let grade: Int
    let `class`: Int
    let number: Int
}

extension UserDTO {
    func toDomain() -> User {
        return .init(
            id: self.id,
            picture: self.picture,
            name: self.name,
            grade: self.grade,
            class: self.class,
            number: self.number
        )
    }
}
