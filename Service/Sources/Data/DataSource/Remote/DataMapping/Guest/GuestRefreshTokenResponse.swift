import Foundation

struct GuestRefreshTokenResponse: Decodable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
