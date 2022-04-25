public struct RelatedLinkDTO: Codable {
    public let name: String
    public let url: String
}

extension RelatedLinkDTO {
    func toDomain() -> RelatedLink {
        return .init(
            name: name,
            url: url
        )
    }
}
