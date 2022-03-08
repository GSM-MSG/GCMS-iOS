import Foundation

public struct User: Equatable {
    public init(id: Int, picture: String, name: String, grade: Int, class: Int, number: Int, joinedMajorClub: Int? = nil, joinedEditorialClub: [Int]? = nil, joinedFreedomClub: Int? = nil) {
        self.id = id
        self.picture = picture
        self.name = name
        self.grade = grade
        self.class = class
        self.number = number
        self.joinedMajorClub = joinedMajorClub
        self.joinedEditorialClub = joinedEditorialClub
        self.joinedFreedomClub = joinedFreedomClub
    }
    
    public let id: Int
    public let picture: String
    public let name: String
    public let grade: Int
    public let `class`: Int
    public let number: Int
    public let joinedMajorClub: Int?
    public let joinedEditorialClub: [Int]?
    public let joinedFreedomClub: Int?
}
