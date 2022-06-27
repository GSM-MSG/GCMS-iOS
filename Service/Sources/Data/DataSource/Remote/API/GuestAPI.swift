import Moya

enum GuestAPI {
    case guestClubList(type: ClubType)
    case guestClubDetail(query: ClubRequestQuery)
}

extension GuestAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .guest
    }
    
    var urlPath: String {
        switch self {
        case .guestClubList:
            return "/list"
        case .guestClubDetail:
            return "/detail"
        }
    }
    
    var method: Method {
        switch self {
        case .guestClubList, .guestClubDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .guestClubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .guestClubDetail(q):
            return .requestParameters(parameters: [
                "q": q.q,
                "type": q.type
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .guestClubList, .guestClubDetail:
            return JWTTokenType.none
        }
    }
    
    var errorMapper: [Int: GCMSError]?{
        switch self {
        case .guestClubList(type: let type):
            <#code#>
        case .guestClubDetail(query: let query):
            <#code#>
        }
    }
}
