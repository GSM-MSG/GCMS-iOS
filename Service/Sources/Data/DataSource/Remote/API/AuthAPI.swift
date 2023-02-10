import Moya

enum AuthAPI {
    case login(code: String)
    case refresh
    case logout
}

extension AuthAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .auth
    }
    var urlPath: String {
        switch self {
        case .login:
            return ""
        case .refresh:
            return ""
        case .logout:
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
        case let .login(req):
            return .requestParameters(parameters: [
                "code": req
            ], encoding: JSONEncoding.default)
            
        case .refresh, .logout:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .logout:
            return .accessToken

        case .refresh:
            return .refreshToken
            
        default:
            return JWTTokenType.none
        }
    }
    var errorMapper: [Int: Error]? {
        switch self {
        case .login:
            return .none

        case .refresh:
            return [
                404: GCMSError.notFoundUser
            ]
        case .logout:
            return [
                401: GCMSError.expriedOrDeteriorationToken,
                404: GCMSError.notFoundUser
            ]
        }
    }
    
}
