struct DetailClubResponse: Codable {
    let type: ClubType
    let bannerUrl: String
    let title: String
    let description: String
    let contact: String
    let head: UserDTO
    let relatedLink: [RelatedLink]
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
            relatedLink: relatedLink,
            scope: scope,
            isApplied: isApplied,
            isOpen: isOpen,
            activities: activities,
            member: [
                .init(
                    userId: "s2103",
                    profileImageUrl: "https://avatars.githubusercontent.com/u/12152522?s=60&v=4",
                    name: "ASDF",
                    grade: 2,
                    class: 3,
                    number: 4,
                    joinedMajorClub: nil,
                    joinedFreedomClub: nil,
                    joinedEditorialClub: nil
                )
            ],
            teacher: teacher
        )
    }
}
