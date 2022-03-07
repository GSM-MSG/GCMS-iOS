import Foundation

public struct User: Equatable {
    public init(id: Int, profileImage: String, name: String, grade: Int, class: Int, number: Int) {
        self.id = id
        self.profileImage = profileImage
        self.name = name
        self.grade = grade
        self.class = `class`
        self.number = number
    }
    
    public let id: Int
    public let profileImage: String
    public let name: String
    public let grade: Int
    public let `class`: Int
    public let number: Int
    
}
