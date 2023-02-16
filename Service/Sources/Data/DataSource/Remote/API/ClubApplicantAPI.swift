import Moya
import Foundation

enum ClubApplicantAPI{
    case applicantList(clubID: Int)
    case apply
    case cancel
    case userAccept(clubID: Int, uuid: UUID)
    case userReject(clubID: Int, uuid: UUID)
}

extension ClubApplicantAPI: GCMSAPI{
    
    var domain: GCMSDomain {
        return .applicant
    }
    
    var urlPath: String{
        switch self {
        case let .applicantList(clubID), let .userAccept(clubID, _), let .userReject(clubID, _):
            return "/\(clubID)"
        case .apply, .cancel:
            return ""
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .applicantList:
            return .get
            
        case .apply:
            return .post
            
        case .cancel:
            return .delete
            
        case .userAccept:
            return .post
            
        case .userReject:
            return .post
        }
    }
    
    var task: Moya.Task{
        switch self {
        case .applicantList, .apply, .cancel:
            return .requestPlain
            
        case let .userAccept(_, uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: JSONEncoding.default)
            
        case let .userReject(_, uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: JSONEncoding.default)
        }
    }
    
    var jwtTokenType: JWTTokenType?{
        switch self{
        default:
            return .accessToken
        }
    }
    
    var errorMapper: [Int : Error]?{
        switch self {
        case .applicantList:
            return[
                400: ClubApplicantError.notClubMember,
                401: ClubApplicantError.unauthorized,
                404: ClubApplicantError.notFoundClub,
                500: ClubApplicantError.serverError
            ]
            
        case .apply:
            return[
                401: ClubApplicantError.unauthorized,
                403: ClubApplicantError.alreadyClubMember,
                404: ClubApplicantError.notFoundClub,
                500: ClubApplicantError.serverError
            ]
            
        case .cancel:
            return[
                401: ClubApplicantError.unauthorized,
                404: ClubApplicantError.notFoundClub,
                500: ClubApplicantError.serverError
            ]
            
        case .userAccept:
            return[
                400: ClubApplicantError.bodyIsNull,
                401: ClubApplicantError.unauthorized,
                403: ClubApplicantError.notClubHead,
                404: ClubApplicantError.notFoundAcceptUser,
                500: ClubApplicantError.serverError
            ]
            
        case .userReject:
            return[
                400: ClubApplicantError.bodyIsNull,
                401: ClubApplicantError.unauthorized,
                403: ClubApplicantError.notClubHead,
                404: ClubApplicantError.notFoundRejectUser,
                500: ClubApplicantError.serverError
            ]
        }
    }
}
