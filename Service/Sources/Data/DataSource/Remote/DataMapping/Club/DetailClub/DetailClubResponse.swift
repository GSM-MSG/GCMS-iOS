struct DetailClubResponse: Codable {
    let club: DetailClubDTO
    let head: UserDTO
    let member: [UserDTO]
    let scope: MemberScope
    let isApplied: Bool
    let activities: [String]
    
    enum CodingKeys: String, CodingKey {
        case head, member, scope, isApplied
        case club = "club"
        case activities = "activityurls"
    }
}

extension DetailClubResponse {
    func toDomain() -> Club {
        return .init(
            type: club.type,
            bannerUrl: club.bannerUrl,
            title: club.title,
            description: club.description,
            contact: club.contact,
            head: head.toDomain(),
            notionLink: club.notionLink,
            scope: scope,
            isApplied: isApplied,
            isOpen: club.isOpened,
            activities: activities,
            member: member.map { $0.toDomain() },
            teacher: club.teacher
        )
    }
}
