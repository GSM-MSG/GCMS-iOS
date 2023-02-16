
public struct ClubList: Equatable {
    public let id: Int
    public let type: ClubType
    public let name: String
    public let content: String
    public let bannerImg: String

    public init(
        id: Int,
        type: ClubType,
        name: String,
        content: String,
        bannerImg: String
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.content = content
        self.bannerImg = bannerImg
    }
}
