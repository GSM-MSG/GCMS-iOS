import Foundation

struct FetchDetailClubResponse: Decodable {
    let id: Int
    let type: ClubType
    let bannerImg: String
    let name: String
    let content: String
    let contact: String
    let teacher: String?
    let isOpened: Bool
    let notionLink: String
    let activityImgs: [String]
    let head: UserDTO
    let member: [UserDTO]
    let scope: MemberScope
    let isApplied: Bool
    
    struct UserDTO: Decodable {
        let uuid: UUID
        let email: String
        let name: String
        let grade: Int
        let classNum: Int
        let number: Int
        let profileImg: String?
    }
}

extension FetchDetailClubResponse {
    func toDomain() -> Club {
        Club(
            clubID: id,
            type: type,
            bannerImg: bannerImg,
            name: name,
            content: content,
            contact: contact,
            head: head.toDomain(),
            notionLink: notionLink,
            scope: scope,
            isApplied: isApplied,
            isOpen: isOpened,
            activityImgs: activityImgs,
            member: member.map { $0.toDomain() },
            teacher: teacher
        )
    }
}

extension FetchDetailClubResponse.UserDTO {
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
