struct RelatedLinkDTO: Codable {
    let name: String
    let url: String
}

extension RelatedLinkDTO {
    func toDomain() -> RelatedLink {
        return .init(
            name: name,
            url: url
        )
    }
}
