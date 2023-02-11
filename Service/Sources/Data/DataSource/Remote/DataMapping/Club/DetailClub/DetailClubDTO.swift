struct DetailClubDTO: Codable {
    let name: String
    let content: String
    let contact: String
    let teacher: String?
    let isOpened: Bool
    let type: ClubType
    let bannerImg: String
    let notionLink: String
}
