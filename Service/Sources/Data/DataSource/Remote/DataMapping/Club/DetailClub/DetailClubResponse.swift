struct DetailClubResponse: Codable {
    let type: ClubType
    let bannerUrl: String
    let title: String
    let description: String
    let contact: String
    let head: UserDTO
    let relatedLink: RelatedLinkDTO
    let member: [UserDTO]
    let scope: MemberScope
    let isApplied: Bool
    let isOpen: Bool
    let activities: [String]
    let teacher: String?
}

extension DetailClubResponse {
    func toDomain() -> Club {
        return .init(
            type: type,
            bannerUrl: bannerUrl,
            title: title,
            description: description,
            contact: contact,
            head: head.toDomain(),
            relatedLink: relatedLink.toDomain(),
            scope: scope,
            isApplied: isApplied,
            isOpen: isOpen,
            activities: activities,
            member: member.map { $0.toDomain() },
            teacher: teacher
        )
    }
}
