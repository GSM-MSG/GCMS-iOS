import Moya

enum AuthAPI {
    case login(code: String, deviceToken: String)
    case refresh(deviceToken: String)
    case logout
}

extension AuthAPI: GCMSAPI {
    typealias ErrorType = GCMSError

    var domain: GCMSDomain {
        return .auth
    }

    var urlPath: String {
        switch self {
        case .login, .refresh, .logout:
            return ""
        }
    }

    var method: Method {
        switch self {
        case .login:
            return .post

        case .refresh:
            return .patch

        case .logout:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case let .login(req, token):
            return .requestParameters(parameters: [
                "code": req,
                "token": token
            ], encoding: JSONEncoding.default)

        case let .refresh(token):
            return .requestParameters(parameters: [
                "token": token
            ], encoding: JSONEncoding.default)

        case .logout:
            return .requestPlain
        }
    }

    var jwtTokenType: JWTTokenType? {
        switch self {
        case .refresh:
            return .refreshToken

        case .logout:
            return .accessToken

        default:
            return JWTTokenType.none
        }
    }

    var errorMapper: [Int: GCMSError]? {
        switch self {
        case .login:
            return [
                500: .serverError
            ]
            
        case .refresh:
            return [
                401: .unauthorized,
                404: .notFoundUser,
                500: .serverError
            ]
            
        case .logout:
            return [
                401: .unauthorized,
                404: .notFoundUser,
                500: .serverError
            ]
        }
    }

}
