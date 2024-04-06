public struct Club: Equatable {
    public init(
        clubID: Int,
        type: ClubType,
        bannerImg: String,
        name: String,
        content: String,
        contact: String,
        head: User,
        notionLink: String,
        scope: MemberScope,
        isApplied: Bool,
        isOpen: Bool,
        activityImgs: [String],
        member: [User],
        teacher: String?
    ) {
        self.clubID = clubID
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

    public var clubID: Int
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
    func copyForChange(
        clubID: Int? = nil,
        type: ClubType? = nil,
        bannerImg: String? = nil,
        name: String? = nil,
        content: String? = nil,
        contact: String? = nil,
        head: User? = nil,
        notionLink: String? = nil,
        scope: MemberScope? = nil,
        isApplied: Bool? = nil,
        isOpen: Bool? = nil,
        activityImgs: [String]? = nil,
        member: [User]? = nil,
        teacher: String? = nil
    ) -> Club {
        return Club(
            clubID: clubID ?? self.clubID,
            type: type ?? self.type,
            bannerImg: bannerImg ?? self.bannerImg,
            name: name ?? self.name,
            content: content ?? self.content,
            contact: contact ?? self.contact,
            head: head ?? self.head,
            notionLink: notionLink ?? self.notionLink,
            scope: scope ?? self.scope,
            isApplied: isApplied ?? self.isApplied,
            isOpen: isOpen ?? self.isOpen,
            activityImgs: activityImgs ?? self.activityImgs,
            member: member ?? self.member,
            teacher: teacher ?? self.teacher
        )
    }
}
