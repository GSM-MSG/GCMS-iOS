import Moya

enum AuthAPI {
    case login(req: LoginRequest)
    case register(req: RegisterReqeust)
    case refresh
    case verify(email: String)
    case isVerified(email: String, code: String)
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
        case .refresh:
            return "/refresh"
        case .verify, .isVerified:
            return "/verify"
        }
    }
    var method: Method {
        switch self {
        case .login, .register, .refresh, .verify:
            return .post
        case .isVerified:
            return .head
        }
    }
    var task: Task {
        switch self {
        case let .login(req):
            return .requestJSONEncodable(req)
        case let .register(req):
            return .requestJSONEncodable(req)
        case .refresh:
            return .requestPlain
        case let .verify(email):
            return .requestParameters(parameters: [
                "email": email
            ], encoding: JSONEncoding.default)
        case let .isVerified(email, code):
            return .requestParameters(parameters: [
                "email": email,
                "code": code
            ], encoding: URLEncoding.queryString)
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
        return [
            403: .Forbidden,
            409: .conflict
        ]
    }
    
}
