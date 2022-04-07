import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case clubDetail(query: ClubRequestQuery)
    case createNewClub(req: NewClubRequest)
    case updateClub(query: ClubRequestQuery, req: NewClubRequest)
    case deleteClub(query: ClubRequestQuery)
    case clubMember(query: ClubRequestQuery)
    case clubApplicant(query: ClubRequestQuery)
    case userAccept(query: ClubRequestQuery, userId: String)
    case userReject(query: ClubRequestQuery, userId: String)
    case clubOpen(query: ClubRequestQuery)
    case clubClose(query: ClubRequestQuery)
    case userKick(query: ClubRequestQuery, userId: String)
}

extension ClubAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .club
    }
    var urlPath: String {
        switch self {
        case .clubList:
            return "/list"
        case .clubDetail:
            return "/detail"
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
        }
    }
    var method: Method {
        switch self {
        case .clubList, .clubDetail, .createNewClub, .clubMember, .clubApplicant:
            return .get
        case .userAccept, .userReject:
            return .post
        case .updateClub, .clubOpen, .clubClose:
            return .put
        case .deleteClub, .userKick:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case let .clubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .clubDetail(q), let .clubMember(q), let .clubApplicant(q):
            return .requestParameters(parameters: [
                "q": q.name,
                "type": q.type
            ], encoding: URLEncoding.queryString)
        case let .createNewClub(req):
            return .requestJSONEncodable(req)
        case let .deleteClub(query), let .clubOpen(query), let .clubClose(query):
            return .requestJSONEncodable(query)
        case let .userAccept(query, userId), let .userReject(query, userId), let .userKick(query, userId):
            return .requestParameters(parameters: [
                "q": query.name,
                "type": query.type.rawValue,
                "userId": userId
            ], encoding: JSONEncoding.default)
        case let .updateClub(query, req):
            return .requestParameters(parameters: [
                "q": query.name,
                "type": query.type.rawValue,
                "title": req.title,
                "description": req.description,
                "bannerUrl": req.bannerUrl,
                "contact": req.contact,
                "relatedLink": req.relatedLink,
                "teacher": req.teacher,
                "activities": req.activities,
                "member": req.member
            ], encoding: JSONEncoding.default)
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }
    var errorMapper: [Int: GCMSError]?{
        return [
            403: .Forbidden,
            409: .conflict
        ]
    }
}
