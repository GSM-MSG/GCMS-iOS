import UIKit

struct ClubMemberResponse: Codable {
    let userScope: MemberScope
    let requestUser: [MemberDTO]
}

extension ClubMemberResponse {
    func toDomain() -> [Member] {
        return requestUser.map { $0.toDomain() }
    }
}
