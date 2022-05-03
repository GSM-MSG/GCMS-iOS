public struct Club: Equatable {
    public init(type: ClubType, bannerUrl: String, title: String, description: String, contact: String, head: User, relatedLink: RelatedLink?, scope: MemberScope, isApplied: Bool, isOpen: Bool, activities: [String], member: [User], teacher: String?) {
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
    public let relatedLink: RelatedLink?
    public let scope: MemberScope
    public let isApplied: Bool
    public let isOpen: Bool
    public let activities: [String]
    public let member: [User]
    public let teacher: String?
}

public extension Club {
    static let dummy = Club(
        type: .major,
        bannerUrl: "https://avatars.githubusercontent.com/u/95753750?s=64&v=4",
        title: "Dummy",
        description: "대충 설명 대충 설명 대\n충 설명",
        contact: "대충 연락처",
        head: .dummy,
        relatedLink: .dummy,
        scope: .default,
        isApplied: .random(),
        isOpen: .random(),
        activities: [
            "https://avatars.githubusercontent.com/u/57276315?s=70&v=4",
            "https://avatars.githubusercontent.com/u/82383983?s=70&v=4"
        ], member: [
            .dummy,
            .dummy
        ], teacher: nil
    )
}
