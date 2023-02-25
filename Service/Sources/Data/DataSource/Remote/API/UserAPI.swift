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

    typealias ErrorType = GCMSError
    var errorMapper: [Int: GCMSError]? {
        switch self {
        case .myProfile, .miniProfile:
            return [
                401: .unauthorized,
                404: .notFoundUser,
                500: .serverError
            ]
            
        case .editProfile:
            return [
                400: .invalidInput,
                401: .unauthorized,
                404: .notFoundUser,
                500: .serverError
            ]
            
        case .search:
            return [
                401: .unauthorized,
                500: .serverError
            ]

        case .withdrawal:
            return [
                401: .unauthorized,
                403: .notExistUser
            ]
        }
    }
}
