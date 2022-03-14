import Moya

enum ClubAPI {
    case newClub(req: NewClubRequest)
    case managementList
    case clubList(type: ClubType)
    case detailClub(name: String, type: ClubType)
    case join(name: String, type: ClubType)
    case members(name: String, type: ClubType)
    case userAccept(userId: Int, name: String, type: ClubType)
    case userReject(userId: Int, name: String, type: ClubType)
    case waitList(name: String, type: ClubType)
    case end(name: String, type: ClubType)
    case notification(name: String, type: ClubType, req: NotificationRequest)
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
        case .detailClub:
            return "/detailPage"
        case .join:
            return "/join"
        case .members:
            return "/members"
        case .userAccept:
            return "accept"
        case .userReject:
            return "reject"
        case .waitList:
            return "/waitlist"
        case .end:
            return "/end"
        case let .notification(name, type, _):
            return "/notification?q=\(name)&type=\(type.rawValue)"
        }
    }
    var method: Method {
        switch self {
        case .newClub, .join, .userAccept, .userReject, .end, .notification:
            return .post
        case .managementList, .clubList, .detailClub, .members, .waitList:
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
        case let .detailClub(name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .join(name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .members(name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .userAccept(userId, name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue,
                "user": userId
            ], encoding: URLEncoding.queryString)
        case let .userReject(userId, name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue,
                "user": userId
            ], encoding: URLEncoding.queryString)
        case let .waitList(name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .end(name, type):
            return .requestParameters(parameters: [
                "q": name,
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .notification(_, _, req):
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
