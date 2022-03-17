import Moya

enum ClubAPI {
    case clubList(type: ClubType)
}

extension ClubAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .club
    }
    var urlPath: String {
        switch self {
        case .clubList:
            return "/list"
        }
    }
    var method: Method {
        switch self {
        case .clubList:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .clubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .clubList:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
