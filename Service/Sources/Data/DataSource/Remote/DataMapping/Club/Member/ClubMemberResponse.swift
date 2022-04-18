import UIKit

struct ClubMemberResponse: Codable {
    let scope: MemberScope
    let user: MemberDTO
}

extension ClubMemberResponse {
    func toDomain() -> Member {
        return .init(
            email: user.email,
            name: user.name,
            grade: user.grade,
            class: user.class,
            number: user.num,
            scope: scope,
            profileImageUrl: user.userImg
        )
    }
}
