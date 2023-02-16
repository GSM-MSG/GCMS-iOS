struct DetailClubDTO: Codable {
    let id: Int
    let type: ClubType
    let bannerImg: String
    let name: String
    let content: String
    let contact: String
    let teacher: String?
    let isOpened: Bool
    let notionLink: String
    let activityImgs: [String]
}
