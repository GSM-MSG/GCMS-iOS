public struct Club: Equatable {
    public init(type: ClubType, bannerUrl: String, title: String, description: String, contact: String, head: User, relatedLink: [RelatedLink], scope: MemberScope, isApplied: Bool, isOpen: Bool, activities: [String], member: [User], teacher: String?) {
        self.type = type
        self.bannerUrl = bannerUrl
        self.title = title
        self.description = description
        self.contact = contact
        self.head = head
        self.relatedLink = relatedLink
        self.scope = scope
        self.isApplied = isApplied
        self.isOpen = isOpen
        self.activities = activities
        self.member = member
        self.teacher = teacher
    }
    
    
    public static func == (lhs: Club, rhs: Club) -> Bool {
        lhs.title == rhs.title && lhs.`type` == rhs.`type`
    }
    
    public let type: ClubType
    public let bannerUrl: String
    public let title: String
    public let description: String
    public let contact: String
    public let head: User
    public let relatedLink: [RelatedLink]
    public let scope: MemberScope
    public let isApplied: Bool
    public let isOpen: Bool
    public let activities: [String]
    public let member: [User]
    public let teacher: String?
}
