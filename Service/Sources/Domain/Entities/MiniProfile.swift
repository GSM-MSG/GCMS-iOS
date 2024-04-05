import Foundation

public struct MiniProfile: Equatable {
    public let name: String
    public let profileImg: String

    public init(
        name: String,
        profileImg: String
    ) {
        self.name = name
        self.profileImg = profileImg
    }
}
