import Moya

enum UserAPI {
    case userInfo
    case editProfile(url: String)
    case search(name: String, type: ClubType)
    case exit(ClubRequestQuery)
}

extension UserAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .user
    }
    var urlPath: String {
        switch self {
        case .userInfo:
            return "/my"
        case .editProfile:
            return "/profile"
        case .search:
            return "/search"
        case .exit:
            return "/exit"
        }
    }
    var method: Method {
        switch self {
        case .userInfo, .search:
            return .get
        case .editProfile:
            return .put
        case .exit:
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
                "q": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)

        case let .exit(query):
            return .requestParameters(parameters: [
                "q": query.name,
                "type": query.type.rawValue
            ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .userInfo, .editProfile, .search, .exit:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
    
    var errorMapper: [Int: GCMSError]?{
        return [
            403: .forbidden,
            409: .conflict
        ]
    }
}
