import Moya

enum ClubAPI {
    case newClub(req: NewClubRequest)
    case managementList
}

extension ClubAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .club
    }
    var urlPath: String {
        switch self {
        case .newClub:
            return "/write"
        case .managementList:
            return "/list/manage"
        }
    }
    var method: Method {
        switch self {
        case .newClub:
            return .post
        case .managementList:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .newClub(req):
            return .requestJSONEncodable(req)
        default:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .newClub, .managementList:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
