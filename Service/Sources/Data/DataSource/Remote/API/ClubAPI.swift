import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case clubDetail(query: ClubRequestQuery)
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
        case .clubDetail:
            return "/detail"
        case .createNewClub, .updateClub:
            return "/"
        case .deleteClub:
            return "/delete"
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
        case .clubList, .clubDetail, .clubMember, .clubApplicant:
            return .get
        case .userAccept, .userReject, .apply, .cancel, .createNewClub, .deleteClub, .userKick:
            return .post
        case .updateClub, .clubOpen, .clubClose, .delegation:
            return .put
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
        default:
            return .accessToken
        }
    }
    var errorMapper: [Int: GCMSError]?{
        switch self {
        case .clubList:
            <#code#>
        case .clubDetail:
            <#code#>
        case .createNewClub:
            <#code#>
        case .updateClub:
            <#code#>
        case .deleteClub:
            <#code#>
        case .clubMember:
            <#code#>
        case .clubApplicant:
            <#code#>
        case .userAccept:
            <#code#>
        case .userReject:
            <#code#>
        case .clubOpen:
            <#code#>
        case .clubClose:
            <#code#>
        case .userKick:
            <#code#>
        case .apply:
            <#code#>
        case .cancel:
            <#code#>
        case .delegation:
            <#code#>
        }
    }
}
