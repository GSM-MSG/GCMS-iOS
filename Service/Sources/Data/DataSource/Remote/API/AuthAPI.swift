import Moya

enum AuthAPI {
    case login(req: LoginRequest)
    case reissue
}

extension AuthAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .auth
    }
    var urlPath: String {
        switch self {
        case .login:
            return "/login"
        case .reissue:
            return "/notice"
        }
    }
    var method: Method {
        switch self {
        case .login:
            return .post
        case .reissue:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .login(req):
            return .requestParameters(parameters: [
                "idToken": req.idToken,
                "deviceToken": req.deviceToken
            ], encoding: JSONEncoding.default)
        case .reissue:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .reissue:
            return .refreshToken
        default:
            return JWTTokenType.none
        }
    }
    
}
