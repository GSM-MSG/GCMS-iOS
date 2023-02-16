import Moya

enum UserAPI {
    case myProfile
    case editProfile(url: String)
    case search(name: String, type: ClubType)
    case miniProfile
    case withdrawal
}

extension UserAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .user
    }

    var urlPath: String {
        switch self {
        case .myProfile, .editProfile, .withdrawal:
            return ""

        case .search:
            return "/search"

        case .miniProfile:
            return "/profile"
        }
    }

    var method: Method {
        switch self {
        case .myProfile, .search, .miniProfile:
            return .get

        case .editProfile:
            return .patch

        case .withdrawal:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case let .editProfile(url):
            return .requestParameters(parameters: [
                "profileImg": url
            ], encoding: JSONEncoding.default)

        case let .search(name, type):
            return .requestParameters(parameters: [
                "name": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)

        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }

    var errorMapper: [Int: Error]?{
        switch self {
        case .myProfile:
            return .none

        case .editProfile:
            return .none

        case .search:
            return .none

        case .withdrawal:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notExistUser
            ]
        }
    }
}
