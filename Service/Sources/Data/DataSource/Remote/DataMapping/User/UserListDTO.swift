struct UserListDTO: Codable {
    let requestUser: [UserDTO]
}

extension UserListDTO {
    func toDomain() -> [User] {
        return requestUser.map { $0.toDomain() }
    }
}
