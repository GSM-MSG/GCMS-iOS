
public struct ClubList {
    public let id: Int
    public let bannerUrl: String
    public let title: String
    public let type: ClubType
    
    public init(
        id: Int,
        bannerUrl: String,
        title: String,
        type: ClubType
    ) {
        self.id = id
        self.bannerUrl = bannerUrl
        self.title = title
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case bannerUrl = "picture"
        case title = "name"
    }
}
