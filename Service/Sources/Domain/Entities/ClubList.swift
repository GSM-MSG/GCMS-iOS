
public struct ClubList: Equatable {
    public let bannerImg: String
    public let name: String
    public let type: ClubType
    
    public init(
        bannerImg: String,
        name: String,
        type: ClubType
    ) {
        self.bannerImg = bannerImg
        self.name = name
        self.type = type
    }
}

public extension ClubList {
    static let dummy = ClubList(
        bannerImg: "https://avatars.githubusercontent.com/u/95753750?s=64&v=4",
        name: "GCMS",
        type: .freedom
    )
}
