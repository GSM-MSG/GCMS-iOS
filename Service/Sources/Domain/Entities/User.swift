import Foundation

public struct User: Equatable {
    public init(userId: String, profileImageUrl: String?, name: String, grade: Int, class: Int, number: Int) {
        self.userId = userId
        self.profileImageUrl = profileImageUrl
        self.name = name
        self.grade = grade
        self.class = `class`
        self.number = number
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userId == rhs.userId
    }
    
    public let userId: String
    public let profileImageUrl: String?
    public let name: String
    public let grade: Int
    public let `class`: Int
    public let number: Int
}

public extension User {
    static let dummy = User(
        userId: "s21073",
        profileImageUrl: "https://avatars.githubusercontent.com/u/74440939?v=4",
        name: "Baekteun",
        grade: 2,
        class: 1,
        number: 18
    )
}
