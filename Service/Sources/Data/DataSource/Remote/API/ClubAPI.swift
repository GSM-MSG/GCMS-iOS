import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case clubDetail(query: ClubRequestQuery)
    case createNewClub(req: NewClubRequest)
    case updateClub(req: UpdateClubRequest)
    case deleteClub(query: ClubRequestQuery)
    case clubApplicant(query: ClubRequestQuery)
    case userAccept(query: ClubRequestQuery, userId: String)
    case userReject(query: ClubRequestQuery, userId: String)
    case clubOpen(query: ClubRequestQuery)
    case clubClose(query: ClubRequestQuery)
    case apply(query: ClubRequestQuery)
    case cancel(query: ClubRequestQuery)
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
        case .apply:
            return "/apply"
        case .cancel:
            return "/cancel"
        }
    }
    var method: Method {
        switch self {
        case .clubList, .clubDetail, .clubApplicant:
            return .get
        case .userAccept, .userReject, .apply, .cancel, .createNewClub, .deleteClub:
            return .post
        case .updateClub, .clubOpen, .clubClose:
            return .put
        }
    }
    var task: Task {
        switch self {
        case let .clubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .clubDetail(q), let .clubApplicant(q):
            return .requestParameters(parameters: [
                "q": q.q,
                "type": q.type.rawValue
            ], encoding: URLEncoding.queryString)
        case let .createNewClub(req):
            return .requestJSONEncodable(req)
        case let .deleteClub(query), let .clubOpen(query), let .clubClose(query):
            return .requestJSONEncodable(query)
        case let .userAccept(query, userId), let .userReject(query, userId):
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
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }
    var errorMapper: [Int: Error]?{
        switch self {
        case .clubList:
            return [
                400: GCMSError.clubTypeError,
                401: GCMSError.unauthorized
            ]
            
        case .clubDetail:
            return [
                400: GCMSError.noMebmerClub,
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundClub
            ]
            
        case .createNewClub:
            return [
                400: GCMSError.alreadyExistClubOrBelongOtherClub,
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundUser,
                409: GCMSError.alreadyExistClubOrBelongOtherClub
            ]
            
        case .updateClub:
            return [
                400: GCMSError.invalidInput,
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundClub
            ]
            
        case .deleteClub:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundClub
            ]
            
        case .clubApplicant:
            return [
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundClub,
                406: GCMSError.notExistInClub
            ]
            
        case .userAccept, .userReject:
            return [
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundInApplyUserOrNotFoundClub,
                409: GCMSError.belongOtherClubOrBelongClub
            ]
            
        case .clubOpen:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead
            ]
            
        case .clubClose:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead
            ]
            
        case .apply:
            return [
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundClub,
                409: GCMSError.appliedToAnotherClubOrBelongClub
            ]
            
        case .cancel:
            return [
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundInApplyUserOrNotFoundClub
            ]
        }
    }
}
