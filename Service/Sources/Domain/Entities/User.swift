import Foundation

public struct User: Equatable {
    public init(userId: String, profileImageUrl: String?, name: String, grade: Int, class: Int, number: Int, joinedMajorClub: ClubList?, joinedFreedomClub: ClubList?, joinedEditorialClub: [ClubList]?) {
        self.userId = userId
        self.profileImageUrl = profileImageUrl
        self.name = name
        self.grade = grade
        self.class = `class`
        self.number = number
        self.joinedMajorClub = joinedMajorClub
        self.joinedFreedomClub = joinedFreedomClub
        self.joinedEditorialClub = joinedEditorialClub
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
    public let joinedMajorClub: ClubList?
    public let joinedFreedomClub: ClubList?
    public let joinedEditorialClub: [ClubList]?
}
