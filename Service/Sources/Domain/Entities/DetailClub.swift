
public struct DetailClub {
    public init(id: Int, bannerUrl: String, name: String, description: String, activities: [String], members: [User], head: User, teacher: User?, contact: String) {
        self.id = id
        self.bannerUrl = bannerUrl
        self.name = name
        self.description = description
        self.activities = activities
        self.members = members
        self.head = head
        self.teacher = teacher
        self.contact = contact
    }
    
    
    public let id: Int
    public let bannerUrl: String
    public let name: String
    public let description: String
    public let activities: [String]
    public let members: [User]
    public let head: User
    public let teacher: User?
    public let contact: String

}
