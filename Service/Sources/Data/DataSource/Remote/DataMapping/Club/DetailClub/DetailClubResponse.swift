struct DetailClubResponse: Codable {
    let club: DetailClubDTO
    let head: UserDTO
    let member: [UserDTO]
    let scope: MemberScope
    let isApplied: Bool
    let activities: [String]
    
    enum CodingKeys: String, CodingKey {
        case club, head, member, scope, isApplied
        case activities = "activityUrls"
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
            relatedLink: club.relatedLink.first?.toDomain(),
            scope: scope,
            isApplied: isApplied,
            isOpen: club.isOpend,
            activities: activities,
            member: member.map { $0.toDomain() },
            teacher: club.teacher
        )
    }
}
