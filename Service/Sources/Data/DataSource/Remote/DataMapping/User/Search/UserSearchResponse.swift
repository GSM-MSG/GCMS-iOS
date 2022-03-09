struct UserSearchResponse: Codable {
    let list: [UserDTO]
}

extension UserSearchResponse {
    func toDomain() -> [User] {
        return self.list.map { $0.toDomain() }
    }
}
