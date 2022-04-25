import UIKit

public struct UpdateClubRequest: Encodable {
    public let q: String
    public let type: ClubType
    public let title: String
    public let description: String
    public let bannerUrl: String
    public let contact: String
    public let relatedLink: RelatedLinkDTO?
    public let teacher: String?
    
}
