import Moya

enum MiscAPI {
    case login(req: LoginRequest)
    case notice
    case reissue
}

extension MiscAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .misc
    }
    var urlPath: String {
        switch self {
        case .login:
            return "login"
        case .notice:
            return "notice"
        case .reissue:
            return "notice"
        }
    }
    var method: Method {
        switch self {
        case .login:
            return .post
        case .notice, .reissue:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .login(req):
            return .requestParameters(parameters: [
                "id_token": req.idToken,
                "deviceToken": req.deviceToken
            ], encoding: JSONEncoding.default)
        case .notice, .reissue:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .notice:
            return .accessToken
        case .reissue:
            return .refreshToken
        default:
            return JWTTokenType.none
        }
    }
}
