import Moya

enum MiscAPI {
    case login(req: LoginRequest)
    case notice
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
        }
    }
    var method: Method {
        switch self {
        case .login:
            return .post
        case .notice:
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
        case .notice:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .notice:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
