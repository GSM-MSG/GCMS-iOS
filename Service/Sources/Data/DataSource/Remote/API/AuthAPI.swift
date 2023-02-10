import Moya

enum AuthAPI {
    case login(code: String)
    case refresh
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
            return "/refresh"
        }
    }
    var method: Method {
        switch self {
        case .login, .refresh:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .login(req):
            return .requestParameters(parameters: [
                "code": req
            ], encoding: JSONEncoding.default)
            
        case .refresh:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
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
            return .none
        }
    }
    
}
