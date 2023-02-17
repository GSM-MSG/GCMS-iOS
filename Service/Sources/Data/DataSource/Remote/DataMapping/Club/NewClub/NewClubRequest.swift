import Foundation

public struct NewClubRequest: Encodable {
    public init(type: ClubType, name: String, content: String, bannerImg: String, contact: String, notionLink: String, teacher: String?, activityImgs: [String], member: [UUID]) {
        self.type = type
        self.name = name
        self.content = content
        self.bannerImg = bannerImg
        self.contact = contact
        self.notionLink = notionLink
        self.teacher = teacher
        self.activityImgs = activityImgs
        self.member = member
    }

    public let type: ClubType
    public let name: String
    public let content: String
    public let bannerImg: String
    public let contact: String
    public let notionLink: String
    public let teacher: String?
    public let activityImgs: [String]
    public let member: [UUID]
}
