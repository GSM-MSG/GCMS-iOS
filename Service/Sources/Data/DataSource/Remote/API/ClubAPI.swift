import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case clubDetail(query: ClubRequestComponent)
    case createNewClub(req: CreateNewClubRequest)
    case updateClub(query: ClubRequestComponent, req: CreateNewClubRequest)
    case deleteClub(query: ClubRequestComponent)
    case clubMember(query: ClubRequestComponent)
    case clubApplicant(query: ClubRequestComponent)
    case userAccept(query: ClubRequestComponent, userId: String)
    case userReject(query: ClubRequestComponent, userId: String)
    case clubOpen(query: ClubRequestComponent)
    case clubClose(query: ClubRequestComponent)
    case userKick(query: ClubRequestComponent, userId: String)
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
}
