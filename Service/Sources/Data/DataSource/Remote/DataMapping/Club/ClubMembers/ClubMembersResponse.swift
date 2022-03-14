
struct ClubMembersResponse: Codable {
    let list: [UserDTO]
}

extension ClubMembersResponse {
    func toDomain() -> [User] {
        return list.map { $0.toDomain() }
    }
}
