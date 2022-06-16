import UIKit

public struct UpdateClubRequest: Encodable {
    public init(q: String, type: ClubType, title: String, description: String, bannerUrl: String, contact: String, notionLink: String, teacher: String?, newActivityUrls: [String], deleteActivityUrls: [String]) {
        self.q = q
        self.type = type
        self.title = title
        self.description = description
        self.bannerUrl = bannerUrl
        self.contact = contact
        self.notionLink = notionLink
        self.teacher = teacher
        self.newActivityUrls = newActivityUrls
        self.deleteActivityUrls = deleteActivityUrls
    }
    
    public let q: String
    public let type: ClubType
    public let title: String
    public let description: String
    public let bannerUrl: String
    public let contact: String
    public let notionLink: String
    public let teacher: String?
    public let newActivityUrls: [String]
    public let deleteActivityUrls: [String]
}
