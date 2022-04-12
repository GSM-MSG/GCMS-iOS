import UIKit

public struct Member: Equatable {
    public init(email: String, name: String, grade: Int, class: Int, number: Int, scope: MemberScope, profileImageUrl: String?) {
        self.email = email
        self.name = name
        self.grade = grade
        self.class = `class`
        self.number = number
        self.scope = scope
        self.profileImageUrl = profileImageUrl
    }
    
    public let email: String
    public let name: String
    public let grade: Int
    public let `class`: Int
    public let number: Int
    public let scope: MemberScope
    public let profileImageUrl: String?
}

public extension Member {
    static let dummy = Member(
        email: "s21038",
        name: "Baek",
        grade: 2,
        class: 1,
        number: 18,
        scope: .member,
        profileImageUrl: "https://avatars.githubusercontent.com/u/74440939?v=4"
    )
}
