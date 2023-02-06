import UIKit

public struct Member: Equatable {
    public init(uuid: UUID, email: String, name: String, grade: Int, classNum: Int, number: Int, scope: MemberScope, profileImg: String?) {
        self.uuid = uuid
        self.email = email
        self.name = name
        self.grade = grade
        self.classNum = classNum
        self.number = number
        self.scope = scope
        self.profileImg = profileImg
    }
    
    public let uuid : UUID
    public let email: String
    public let name: String
    public let grade: Int
    public let classNum: Int
    public let number: Int
    public let scope: MemberScope
    public let profileImg: String?
}

public extension Member {
    static let dummy = Member(
        uuid: UUID(),
        email: "s21038",
        name: "Beak",
        grade: 2,
        classNum: 1,
        number: 18,
        scope: .member,
        profileImg: "https://avatars.githubusercontent.com/u/74440939?v=4"
    )
}
