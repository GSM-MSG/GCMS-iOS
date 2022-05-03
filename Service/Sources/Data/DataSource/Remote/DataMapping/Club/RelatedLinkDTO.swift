public struct RelatedLinkDTO: Codable {
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
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
