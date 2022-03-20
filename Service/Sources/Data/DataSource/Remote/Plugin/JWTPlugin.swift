import Moya
import Foundation

protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

enum JWTTokenType {
    case accessToken
    case refreshToken
    case none
}

final class JWTPlugin: PluginType {
    
    func prepare(
        _ request: URLRequest,
        target: TargetType
    ) throws -> URLRequest {
        guard let authorizable = target as? JWTTokenAuthorizable,
              let tokenType = authorizable.jwtTokenType,
              tokenType != .none
        else { return request }
        
        var request = request
        
        
        let token = "Bearer \(getToken(type: tokenType))"
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func didReceive(
        _ result: Result<Response, MoyaError>,
        target: TargetType
    ) {
        switch result {
        case let .success(res):
            if let newToken = try? res.map(TokenDTO.self) {
                self.setToken(token: newToken)
            }
        default:
            break
        }
    }
}

private extension JWTPlugin {
    func getToken(type: JWTTokenType) -> String {
        switch type {
        case .accessToken:
            return getAccessToken()
        case .refreshToken:
            return getRefreshToken()
        case .none:
            return ""
        }
    }
    
    func getAccessToken() -> String {
        do {
            return try KeychainLocal.shared.fetchAccessToken()
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func getRefreshToken() -> String {
        do {
            return try KeychainLocal.shared.fetchRefreshToken()
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func setToken(token: TokenDTO) {
        KeychainLocal.shared.saveAccessToken(token.accessToken)
        KeychainLocal.shared.saveRefreshToken(token.refreshToken)
    }
}
