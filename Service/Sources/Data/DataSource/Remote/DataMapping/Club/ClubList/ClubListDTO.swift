struct ClubListDTO: Codable {
    let id: Int
    let picture: String
    let name: String
    let type: ClubType
}

extension ClubListDTO {
    func toDomain() -> ClubList {
        return .init(
            id: self.id,
            bannerUrl: self.picture,
            title: self.name,
            type: self.type
        )
    }
}
