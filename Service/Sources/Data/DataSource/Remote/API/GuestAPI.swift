import Moya

enum GuestAPI {
    case guestClubList(type: ClubType)
    case guestClubDetail(query: ClubRequestQuery)
    case tokenIssue(idToken: String, code: String)
    case tokenRevoke(refreshToken: String)
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
            
        case .tokenIssue:
            return "/apple"
            
        case .tokenRevoke:
            return "/apple/revoke"
        }
    }
    
    var method: Method {
        switch self {
        case .guestClubList, .guestClubDetail:
            return .get
            
        case .tokenIssue, .tokenRevoke:
            return .post
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
            
        case let .tokenIssue(idToken, code):
            return .requestParameters(parameters: [
                "idToken": idToken,
                "code": code
            ], encoding: JSONEncoding.default)
            
        case let .tokenRevoke(refreshToken):
            return .requestParameters(parameters: [
                "refreshToken": refreshToken
            ], encoding: JSONEncoding.default)
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return JWTTokenType.none
    }
    
    var errorMapper: [Int: Error]?{
        switch self {
        case .guestClubList:
            return [
                400: GCMSError.clubTypeError,
                401: GCMSError.unauthorized
            ]
            
        case .guestClubDetail:
            return [
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundClub
            ]
            
        case .tokenIssue, .tokenRevoke:
            return [
                400: GCMSError.failedAppleLogin
            ]
        }
    }
}
