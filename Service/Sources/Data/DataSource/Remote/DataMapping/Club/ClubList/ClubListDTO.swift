struct ClubListDTO: Codable {
    let title: String
    let type: ClubType
    let bannerUrl: String
}

extension ClubListDTO {
    func toDomain() -> ClubList {
        return .init(
            bannerUrl: bannerUrl,
            title: title,
            type: type)
    }
}
