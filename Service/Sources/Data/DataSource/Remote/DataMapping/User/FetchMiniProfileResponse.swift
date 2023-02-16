import Foundation

struct FetchMiniProfileResponse: Decodable {
    let name: String
    let profileImg: String
}

extension FetchMiniProfileResponse {
    func toDomain() -> MiniProfile {
        MiniProfile(
            name: name,
            profileImg: profileImg
        )
    }
}
