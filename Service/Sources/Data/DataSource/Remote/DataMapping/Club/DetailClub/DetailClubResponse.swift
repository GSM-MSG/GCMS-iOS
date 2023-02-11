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
        case activities = "activityUrls"
    }
}

extension DetailClubResponse {
    func toDomain() -> Club {
        return .init(
            clubID: club.id,
            type: club.type,
            bannerImg: club.bannerImg,
            name: club.name,
            content: club.content,
            contact: club.contact,
            head: head.toDomain(),
            notionLink: club.notionLink,
            scope: scope,
            isApplied: isApplied,
            isOpen: club.isOpened,
            activityImgs: club.activityImgs,
            member: member.map { $0.toDomain() },
            teacher: club.teacher
        )
    }
}
