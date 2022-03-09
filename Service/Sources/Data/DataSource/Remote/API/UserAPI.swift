import Moya

enum UserAPI {
    case userInfo
    case editPicture(url: String)
    case search(String)
    case notice
    case accept(clubId: Int)
    case reject(clubId: Int)
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
        case .notice:
            return "/notice"
        case let .accept(clubId):
            return "/invite/accept/\(clubId)"
        case let .reject(clubId):
            return "/invite/reject/\(clubId)"
        }
    }
    var method: Method {
        switch self {
        case .userInfo, .search, .notice:
            return .get
        case .editPicture, .accept:
            return .put
        case .reject:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case let .editPicture(url):
            return .requestParameters(parameters: [
                "pictureUrll": url
            ], encoding: JSONEncoding.default)
        case let .search(q):
            return .requestParameters(parameters: [
                "q": q
            ], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .userInfo, .editPicture, .search, .notice, .accept, .reject:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
