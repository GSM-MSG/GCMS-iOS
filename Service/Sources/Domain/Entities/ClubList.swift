
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

public extension ClubList {
    static let dummy = ClubList(
        bannerUrl: "https://avatars.githubusercontent.com/u/95753750?s=64&v=4",
        title: "GCMS",
        type: .freedom
    )
}
