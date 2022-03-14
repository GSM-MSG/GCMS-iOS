struct ClubWaitListResponse: Codable {
    let list: [UserDTO]
}

extension ClubWaitListResponse {
    func toDomain() -> [User] {
        return list.map { $0.toDomain() }
    }
}
