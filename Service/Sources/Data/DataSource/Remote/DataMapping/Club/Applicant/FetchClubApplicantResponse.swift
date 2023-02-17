import Foundation

struct FetchClubApplicantResponse: Decodable {
    let userScope: MemberScope
    let applicantList: [ApplicantResponse]

    struct ApplicantResponse: Decodable {
        let uuid: UUID
        let email: String
        let name: String
        let grade: Int
        let classNum: Int
        let number: Int
        let profileImg: String?
    }
}

extension FetchClubApplicantResponse.ApplicantResponse {
    func toDomain() -> User {
        User(
            uuid: uuid,
            email: email,
            name: name,
            grade: grade,
            classNum: classNum,
            number: number,
            profileImg: profileImg
        )
    }
}

extension FetchClubApplicantResponse {
    func toDomain() -> (MemberScope, [User]) {
        (
            userScope,
            applicantList
                .map { $0.toDomain() }
        )
    }
}
