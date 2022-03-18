struct UserListDTO: Codable {
    let list: [UserDTO]
}

extension UserListDTO {
    func toDomain() -> [User] {
        return list.map { $0.toDomain() }
    }
}
