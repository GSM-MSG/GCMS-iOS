
public struct ClubList {
    public let bannerUrl: String
    public let title: String
    public let type: ClubType
    
    public init(
        bannerUrl: String,
        title: String,
        type: ClubType
    ) {
        self.bannerUrl = bannerUrl
        self.title = title
        self.type = type
    }
}
