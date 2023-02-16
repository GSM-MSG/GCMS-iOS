import Foundation

struct FetchClubMemberResponse: Decodable {
    let scope: MemberScope
    let clubMember: [MemberResponse]
    
    struct MemberResponse: Decodable {
        let uuid: UUID
        let email: String
        let name: String
        let grade: Int
        let classNum: Int
        let number: Int
        let profileImg: String?
        let scope: MemberScope
    }
}

extension FetchClubMemberResponse {
    func toDomain() -> (MemberScope, [Member]) {
        (
            scope,
            clubMember
                .map { $0.toDomain() }
        )
    }
}

extension FetchClubMemberResponse.MemberResponse {
    func toDomain() -> Member {
        Member(
            uuid: uuid,
            email: email,
            name: name,
            grade: grade,
            classNum: classNum,
            number: number,
            scope: scope,
            profileImg: profileImg
        )
    }
}
