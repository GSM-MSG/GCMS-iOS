import Moya

enum AuthAPI {
    case login(req: LoginRequest)
    case register(req: RegisterReqeust)
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
        case .register:
            return "/register"
        case .reissue:
            return "/notice"
        }
    }
    var method: Method {
        switch self {
        case .login, .register:
            return .post
        case .reissue:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)
        case let .register(req):
            return .requestJSONEncodable(req)
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
