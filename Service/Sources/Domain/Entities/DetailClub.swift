
public struct DetailClub {
    public init(id: Int, bannerUrl: String, name: String, description: String, activities: [String], members: [User], head: String, teacher: String, contact: String, isDeadline: Bool, isHead: Bool, isApplied: Bool) {
        self.id = id
        self.bannerUrl = bannerUrl
        self.name = name
        self.description = description
        self.activities = activities
        self.members = members
        self.head = head
        self.teacher = teacher
        self.contact = contact
        self.isDeadline = isDeadline
        self.isHead = isHead
        self.isApplied = isApplied
    }
    
    
    public let id: Int
    public let bannerUrl: String
    public let name: String
    public let description: String
    public let activities: [String]
    public let members: [User]
    public let head: String
    public let teacher: String
    public let contact: String
    public let isDeadline: Bool
    public let isHead: Bool
    public let isApplied: Bool

}
