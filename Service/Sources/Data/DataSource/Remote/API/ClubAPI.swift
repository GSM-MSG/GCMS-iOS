import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case guestClubList(type: ClubType)
    case clubDetail(query: ClubRequestQuery)
    case guestClubDetail(query: ClubRequestQuery)
    case createNewClub(req: NewClubRequest)
    case updateClub(req: UpdateClubRequest)
    case deleteClub(query: ClubRequestQuery)
    case clubMember(query: ClubRequestQuery)
    case clubApplicant(query: ClubRequestQuery)
    case userAccept(query: ClubRequestQuery, userId: String)
    case userReject(query: ClubRequestQuery, userId: String)
    case clubOpen(query: ClubRequestQuery)
    case clubClose(query: ClubRequestQuery)
    case userKick(query: ClubRequestQuery, userId: String)
    case apply(query: ClubRequestQuery)
    case cancel(query: ClubRequestQuery)
    case delegation(query: ClubRequestQuery, userId: String)
}

extension ClubAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .club
    }
    var urlPath: String {
        switch self {
        case .clubList:
            return "/list"
        case .guestClubList:
            return "/guest/list"
        case .clubDetail:
            return "/detail"
        case .guestClubDetail:
            return "/guest/detail"
        case .createNewClub, .updateClub, .deleteClub:
            return "/"
        case .clubMember:
            return "/members"
        case .clubApplicant:
            return "/applicant"
        case .userAccept:
            return "/accept"
        case .userReject:
            return "/reject"
        case .clubOpen:
            return "/open"
        case .clubClose:
            return "/close"
        case .userKick:
            return "/kick"
        case .apply:
            return "/apply"
        case .cancel:
            return "/cancel"
        case .delegation:
            return "/delegation"
        }
    }
    var method: Method {
        switch self {
        case .clubList, .clubDetail, .clubMember, .clubApplicant, .guestClubList, .guestClubDetail:
            return .get
        case .userAccept, .userReject, .apply, .cancel, .createNewClub:
            return .post
        case .updateClub, .clubOpen, .clubClose, .delegation:
            return .put
        case .deleteClub, .userKick:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case let .clubList(type), let .guestClubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .clubDetail(q), let .clubMember(q), let .clubApplicant(q), let .guestClubDetail(q):
            return .requestParameters(parameters: [
                "q": q.q,
                "type": q.type
            ], encoding: URLEncoding.queryString)
        case let .createNewClub(req):
            return .requestJSONEncodable(req)
        case let .deleteClub(query), let .clubOpen(query), let .clubClose(query):
            return .requestJSONEncodable(query)
        case let .userAccept(query, userId), let .userReject(query, userId), let .userKick(query, userId):
            return .requestParameters(parameters: [
                "q": query.q,
                "type": query.type.rawValue,
                "userId": userId
            ], encoding: JSONEncoding.default)
        case let .updateClub(req):
            return .requestJSONEncodable(req)
        case let .apply(query):
            return .requestJSONEncodable(query)
        case let .cancel(query):
            return .requestJSONEncodable(query)
        case let .delegation(query, userId):
            return .requestParameters(parameters: [
                "q": query.q,
                "type": query.type.rawValue,
                "email": userId
            ], encoding: JSONEncoding.default)
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .guestClubList, .guestClubDetail:
            return JWTTokenType.none
        default:
            return .accessToken
        }
    }
    var errorMapper: [Int: GCMSError]?{
        return [
            403: .forbidden,
            409: .conflict
        ]
    }
}
