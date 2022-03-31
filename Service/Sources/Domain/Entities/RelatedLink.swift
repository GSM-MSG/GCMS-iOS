
public struct RelatedLink: Codable {
    public let name: String
    public let url: String
}

public extension RelatedLink {
    static let dummy = RelatedLink(
        name: "깃허브",
        url: "https://github.com/GSM-MSG"
    )
}
