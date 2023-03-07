import Foundation

struct SingleClubListResponse: Decodable {
    let id: Int
    let type: ClubType
    let name: String
    let content: String
    let bannerImg: String
}

extension SingleClubListResponse {
    func toDomain() -> ClubList {
        ClubList(
            id: id,
            type: type,
            name: name,
            content: content,
            bannerImg: bannerImg.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        )
    }
}
