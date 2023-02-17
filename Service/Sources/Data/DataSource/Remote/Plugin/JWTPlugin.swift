import Moya
import Foundation

protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

enum JWTTokenType: String {
    case accessToken = "Authorization"
    case refreshToken = "Refresh-Token"
    case none = ""
}

final class JWTPlugin: PluginType {

    func prepare(
        _ request: URLRequest,
        target: TargetType
    ) -> URLRequest {
        guard let authorizable = target as? JWTTokenAuthorizable,
              let tokenType = authorizable.jwtTokenType,
              tokenType != .none
        else { return request }

        var req = request

        let token = "Bearer \(getToken(type: tokenType))"
        req.addValue(token, forHTTPHeaderField: tokenType.rawValue)
        return req
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
            return ""
        }
    }

    func getRefreshToken() -> String {
        do {
            return try KeychainLocal.shared.fetchRefreshToken()
        } catch {
            return ""
        }
    }

    func setToken(token: TokenDTO) {
        KeychainLocal.shared.saveAccessToken(token.accessToken)
        KeychainLocal.shared.saveRefreshToken(token.refreshToken)
        KeychainLocal.shared.saveAccessExp(token.accessExp)
        KeychainLocal.shared.saveRefreshExp(token.refreshExp)
    }
}
