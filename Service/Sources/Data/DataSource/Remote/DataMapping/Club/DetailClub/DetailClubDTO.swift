struct DetailClubDTO: Codable {
    let title: String
    let description: String
    let contact: String
    let teacher: String?
    let isOpened: Bool
    let type: ClubType
    let bannerUrl: String
    let relatedLink: [RelatedLinkDTO]
}
