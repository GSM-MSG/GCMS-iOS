struct JoinedClubResponse: Codable {
    let clubId: JoinedClubDTO
}

extension JoinedClubResponse {
    func toDomain() -> ClubList {
        return clubId.toDomain()
    }
}
