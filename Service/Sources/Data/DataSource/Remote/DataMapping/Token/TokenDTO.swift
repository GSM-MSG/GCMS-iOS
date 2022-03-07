import Foundation

struct TokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}
