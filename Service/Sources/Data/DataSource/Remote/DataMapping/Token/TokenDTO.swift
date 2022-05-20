import Foundation

struct TokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiredAt: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken, refreshToken
        case expiredAt = "AtExpired"
    }
}
