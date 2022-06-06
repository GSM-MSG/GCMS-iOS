public struct NewClubRequest: Encodable {
    public init(type: ClubType, title: String, description: String, bannerUrl: String, contact: String, notionLink: String, teacher: String?, activities: [String], member: [String]) {
        self.type = type
        self.title = title
        self.description = description
        self.bannerUrl = bannerUrl
        self.contact = contact
        self.notionLink = notionLink
        self.teacher = teacher
        self.activityUrls = activities
        self.member = member
    }
    
    
    public let type: ClubType
    public let title: String
    public let description: String
    public let bannerUrl: String
    public let contact: String
    public let notionLink: String
    public let teacher: String?
    public let activityUrls: [String]
    public let member: [String]
}
