struct DetailClubResponse: Codable {
    let id: Int
    let picture: String
    let type: ClubType
    let name: String
    let description: String
    let teacher: String
    let head: String
    let headId: Int
    let discord: String
    let isDeadline: Bool
    let isApplied: Bool
    let isHead: Bool
    let clubPicture: [String]
    let clubMember: [UserDTO]
}

extension DetailClubResponse {
    func toDomain() -> DetailClub {
        return .init(
            id: self.id,
            bannerUrl: self.picture,
            name: self.name,
            description: self.description,
            activities: self.clubPicture,
            members: self.clubMember.map { $0.toDomain() },
            head: self.head,
            teacher: self.head,
            contact: self.discord,
            isDeadline: self.isDeadline,
            isHead: self.isHead,
            isApplied: self.isApplied
        )
    }
}
