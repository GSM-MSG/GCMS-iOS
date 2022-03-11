import Moya

enum ClubAPI {
    case newClub(req: NewClubRequest)
    case managementList
    case clubList(type: ClubType)
    case detailClub(Int)
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
        case .clubList:
            return "/list"
        case let .detailClub(id):
            return "/detailPage/\(id)"
        }
    }
    var method: Method {
        switch self {
        case .newClub:
            return .post
        case .managementList, .clubList, .detailClub:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .newClub(req):
            return .requestJSONEncodable(req)
        case let .clubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
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
