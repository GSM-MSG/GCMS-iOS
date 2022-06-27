import Moya

enum AuthAPI {
    case login(idToken: String)
    case refresh
}

extension AuthAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .auth
    }
    var urlPath: String {
        switch self {
        case .login:
            return "/mobile"
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
                "idToken": req
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
    var errorMapper: [Int: GCMSError]?{
        switch self {
        case .login:
            return [
                403: .notGSMAccount,
                404: .notFoundInGSM,
                404: .notFoundEmail
            ]
        case .refresh:
            return [
                400: .invalidToken
            ]
        }
    }
    
}
