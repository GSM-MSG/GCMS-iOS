public struct NewClubRequest: Encodable {
    let title: String
    let description: String
    let bannerUrl: String
    let contact: String
    let relatedLink: [RelatedLinkDTO]
    let teacher: String?
    let activities: [String]
    let member: [String]
}
