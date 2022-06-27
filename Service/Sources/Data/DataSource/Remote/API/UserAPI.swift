import Moya

enum UserAPI {
    case myProfile
    case editProfile(url: String)
    case search(name: String, type: ClubType)
    case exit(ClubRequestQuery)
    case withdrawal
}

extension UserAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .user
    }
    var urlPath: String {
        switch self {
        case .myProfile:
            return "/my"
        case .editProfile:
            return "/profile"
        case .search:
            return "/search"
        case .exit:
            return "/exit"
        case .withdrawal:
            return "/withdrawal"
        }
    }
    var method: Method {
        switch self {
        case .myProfile, .search:
            return .get
        case .exit:
            return .post
        case .editProfile:
            return .put
        case .withdrawal:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case let .editProfile(url):
            return .requestParameters(parameters: [
                "url": url
            ], encoding: JSONEncoding.default)
        case let .search(name, type):
            return .requestParameters(parameters: [
                "name": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)

        case let .exit(query):
            return .requestParameters(parameters: [
                "q": query.q,
                "type": query.type.rawValue
            ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .myProfile, .editProfile, .search, .exit, .withdrawal:
            return .accessToken
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
