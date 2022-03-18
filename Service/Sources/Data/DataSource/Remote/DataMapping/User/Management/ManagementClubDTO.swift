struct ManagementClubResponseDTO: Codable {
    let id: Int
    let picture: String
    let name: String
    let type: ClubType
}

extension ManagementClubResponseDTO {
    func toDomain() -> ClubList {
        return .init(
            bannerUrl: self.picture,
            title: self.name,
            type: self.type
        )
    }
}
