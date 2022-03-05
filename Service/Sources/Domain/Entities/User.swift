import Foundation

public struct User {
    public init(id: UUID, profileImage: String, name: String) {
        self.id = id
        self.profileImage = profileImage
        self.name = name
    }
    public let id: UUID
    public let profileImage: String
    public let name: String
}
