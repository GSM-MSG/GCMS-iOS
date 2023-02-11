public struct Club: Equatable {
    public init(type: ClubType, bannerImg: String, name: String, content: String, contact: String, head: User, notionLink: String, scope: MemberScope, isApplied: Bool, isOpen: Bool, activityImgs: [String], member: [User], teacher: String?) {
        self.type = type
        self.bannerImg = bannerImg
        self.name = name
        self.content = content
        self.contact = contact
        self.head = head
        self.notionLink = notionLink
        self.scope = scope
        self.isApplied = isApplied
        self.isOpen = isOpen
        self.activityImgs = activityImgs
        self.member = member
        self.teacher = teacher
    }
    
    
    public static func == (lhs: Club, rhs: Club) -> Bool {
        lhs.name == rhs.name && lhs.`type` == rhs.`type`
    }
    
    public var type: ClubType
    public var bannerImg: String
    public var name: String
    public var content: String
    public var contact: String
    public var head: User
    public var notionLink: String
    public var scope: MemberScope
    public var isApplied: Bool
    public var isOpen: Bool
    public var activityImgs: [String]
    public var member: [User]
    public var teacher: String?
}

public extension Club {
    static let dummy = Club(
        type: .major,
        bannerUrl: "https://avatars.githubusercontent.com/u/95753750?s=64&v=4",
        title: "Dummy",
        description: "대충 설명 대충 설명 대\n충 설명",
        contact: "대충 연락처",
        head: .dummy,
        notionLink: "https://github.com/baekteun",
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
    public func copyForChange(
        type: ClubType? = nil,
        bannerUrl: String? = nil,
        title: String? = nil,
        description: String? = nil,
        contact: String? = nil,
        head: User? = nil,
        notionLink: String? = nil,
        scope: MemberScope? = nil,
        isApplied: Bool? = nil,
        isOpen: Bool? = nil,
        activities: [String]? = nil,
        member: [User]? = nil,
        teacher: String? = nil
    ) -> Club {
        return Club(
            type: type ?? self.type,
            bannerUrl: bannerUrl ?? self.bannerUrl,
            title: title ?? self.title,
            description: description ?? self.description,
            contact: contact ?? self.contact,
            head: head ?? self.head,
            notionLink: notionLink ?? self.notionLink,
            scope: scope ?? self.scope,
            isApplied: isApplied ?? self.isApplied,
            isOpen: isOpen ?? self.isOpen,
            activities: activities ?? self.activities,
            member: member ?? self.member,
            teacher: teacher ?? self.teacher
        )
    }
}
