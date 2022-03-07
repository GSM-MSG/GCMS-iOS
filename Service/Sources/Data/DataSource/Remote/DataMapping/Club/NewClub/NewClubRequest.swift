import Foundation

public struct NewClubRequest {
    public let photo: String
    public let type: ClubType
    public let name: String
    public let description: String
    public let teacher: String
    public let head: String
    public let discord: String
    public let clubPhoto: [String]
    public let clubMember: [Int]
}
