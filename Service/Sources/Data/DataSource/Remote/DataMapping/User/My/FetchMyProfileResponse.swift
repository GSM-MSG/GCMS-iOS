import Foundation

struct FetchMyProfileResponse: Decodable {
    let uuid: UUID
    let email: String
    let name: String
    let grade: Int
    let classNum: Int
    let number: Int
    let profileImg: String?
    let clubs: [ClubListResponse]

    struct ClubListResponse: Decodable {
        let id: Int
        let type: ClubType
        let name: String
        let content: String
        let bannerImg: String
    }
}

extension FetchMyProfileResponse {
    func toDomain() -> UserProfile {
        UserProfile(
            uuid: uuid,
            email: email,
            name: name,
            grade: grade,
            classNum: classNum,
            number: number,
            profileImg: profileImg,
            clubs: clubs.map { $0.toDomain() }
        )
    }
}

extension FetchMyProfileResponse.ClubListResponse {
    func toDomain() -> ClubList {
        ClubList(
            id: id,
            type: type,
            name: name,
            content: content,
            bannerImg: bannerImg
        )
    }
}
