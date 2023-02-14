import UIKit

struct ClubApplicantResponse: Codable {
    let userData: [UserDTO]
}

extension ClubApplicantResponse {
    func toDomain() -> [User] {
        return userData.map { $0.toDomain() }
    }
}
