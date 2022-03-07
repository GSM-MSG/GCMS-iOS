import Moya

enum UserAPI {
    case userInfo
    case editPicture(url: String)
    case search(String)
}

extension UserAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .user
    }
    var urlPath: String {
        switch self {
        case .userInfo:
            return "/"
        case .editPicture:
            return "/edit/picture"
        case .search:
            return "/search"
        }
    }
    var method: Method {
        switch self {
        case .userInfo:
            return .get
        case .editPicture:
            return .put
        case .search:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .userInfo:
            return .requestPlain
        case let .editPicture(url):
            return .requestParameters(parameters: [
                "photo_url": url
            ], encoding: JSONEncoding.default)
        case let .search(q):
            return .requestParameters(parameters: [
                "q": q
            ], encoding: URLEncoding.queryString)
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .userInfo, .editPicture, .search:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
