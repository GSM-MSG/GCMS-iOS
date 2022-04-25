public struct NewClubRequest: Encodable {
    public init(title: String, description: String, bannerUrl: String, contact: String, relatedLink: RelatedLinkDTO, teacher: String?, activities: [String], member: [String]) {
        self.title = title
        self.description = description
        self.bannerUrl = bannerUrl
        self.contact = contact
        self.relatedLink = relatedLink
        self.teacher = teacher
        self.activities = activities
        self.member = member
    }
    
    public let title: String
    public let description: String
    public let bannerUrl: String
    public let contact: String
    public let relatedLink: RelatedLinkDTO
    public let teacher: String?
    public let activities: [String]
    public let member: [String]
}
