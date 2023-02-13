struct ClubListDTO: Codable {
    let name: String
    let type: ClubType
    let bannerImg: String
}

extension ClubListDTO {
    func toDomain() -> ClubList {
        return .init(
            bannerImg: bannerImg,
            name: name,
            type: type)
    }
}
