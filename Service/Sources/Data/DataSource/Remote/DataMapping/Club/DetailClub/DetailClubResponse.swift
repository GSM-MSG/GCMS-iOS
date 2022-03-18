struct DetailClubResponse: Codable {
    let type: ClubType
    let bannerUrl: String
    let title: String
    let description: String
    let head: UserDTO
}
