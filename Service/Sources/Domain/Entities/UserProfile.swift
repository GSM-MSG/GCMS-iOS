import Foundation

public struct UserProfile: Equatable {
    public init(uuid: UUID, email: String, name: String, grade: Int, classNum: Int, number: Int, profileImg: String?, clubs: [ClubList]) {
        self.uuid = uuid
        self.email = email
        self.name = name
        self.grade = grade
        self.classNum = classNum
        self.number = number
        self.profileImg = profileImg
        self.clubs = clubs
    }
    
    
    public static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.email == rhs.email
    }
    
    public let uuid: UUID
    public let email: String
    public let name: String
    public let grade: Int
    public let classNum: Int
    public let number: Int
    public let profileImg: String?
    public let clubs: [ClubList]
}

