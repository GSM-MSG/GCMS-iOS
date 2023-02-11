import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case clubDetail(clubID: Int)
    case createNewClub(req: NewClubRequest)
    case updateClub(clubID: Int, req: UpdateClubRequest)
    case deleteClub(clubID: Int)
    case clubOpen(clubID: Int)
    case clubClose(clubID: Int)
    case exitClub(clubID: Int)
}

extension ClubAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .club
    }
    var urlPath: String {
        switch self {
        case .clubList, .createNewClub:
            return "/"
            
        case let .clubDetail(clubID), let .updateClub(clubID, _), let .deleteClub(clubID):
            return "/\(clubID)"
            
        case let .clubOpen(clubID):
            return "/\(clubID)/open"
            
        case let .clubClose(clubID):
            return "/\(clubID)/close"
            
        case let .exitClub(clubID):
            return "/\(clubID)/exit"
        }
    }
    var method: Method {
        switch self {
        case .clubList, .clubDetail:
            return .get
            
        case .createNewClub:
            return .post
            
        case .updateClub, .clubOpen, .clubClose:
            return .patch
            
        case .deleteClub, .exitClub:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case let .clubList(type):
            return .requestParameters(parameters: [
                "type": type.rawValue
            ], encoding: URLEncoding.queryString)
            
        case .clubDetail, .clubOpen, .clubClose, .exitClub, .deleteClub:
            return .requestPlain
        
        case let .createNewClub(req):
            return .requestJSONEncodable(req)
            
        case let .updateClub(_, req):
            return .requestJSONEncodable(req)
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
                400: GCMSError.invalidInput,
                401: GCMSError.unauthorized,
                500: GCMSError.serverError
            ]
            
        case .clubDetail:
            return [
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundUserOrNotFoundClub,
                500: GCMSError.serverError
            ]
            
        case .createNewClub:
            return [
                400: GCMSError.invalidInput,
                401: GCMSError.unauthorized,
                409: GCMSError.alreadyExistClub,
                500: GCMSError.serverError
            ]
            
        case .updateClub:
            return [
                400: GCMSError.invalidInput,
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundClub,
                500: GCMSError.serverError
            ]
            
        case .deleteClub:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundClub,
                500: GCMSError.serverError
            ]
            
        case .clubOpen:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundClub,
                500: GCMSError.serverError
            ]
            
        case .clubClose:
            return [
                401: GCMSError.unauthorized,
                403: GCMSError.notClubHead,
                404: GCMSError.notFoundClub,
                500: GCMSError.serverError
            ]
            
        case .exitClub:
            return [
                400: GCMSError.noMebmerClub,
                401: GCMSError.unauthorized,
                404: GCMSError.notFoundClub,
                500: GCMSError.serverError
            ]
        }
    }
}
