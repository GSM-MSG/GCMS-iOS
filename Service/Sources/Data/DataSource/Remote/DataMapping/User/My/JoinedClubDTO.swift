
struct JoinedClubDTO: Codable {
    let title: String
    let type: ClubType
    let bannerUrl: String
}

extension JoinedClubDTO {
    func toDomain() -> ClubList {
        return .init(
            bannerUrl: bannerUrl,
            title: title,
            type: type
        )
    }
}

