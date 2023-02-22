import Moya
import Foundation

enum ClubApplicantAPI {
    case applicantList(clubID: Int)
    case apply(clubID: Int)
    case cancel(clubID: Int)
    case userAccept(clubID: Int, uuid: UUID)
    case userReject(clubID: Int, uuid: UUID)
}

extension ClubApplicantAPI: GCMSAPI {

    var domain: GCMSDomain {
        return .applicant
    }

    var urlPath: String {
        switch self {
        case let .applicantList(clubID), let .userAccept(clubID, _), let .userReject(clubID, _), let .apply(clubID), let .cancel(clubID):
            return "/\(clubID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .applicantList:
            return .get

        case .apply, .userAccept, .userReject:
            return .post

        case .cancel:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .applicantList, .apply, .cancel:
            return .requestPlain

        case let .userAccept(_, uuid):
            return .requestParameters(parameters: [
                "uuid": "\(uuid)"
            ], encoding: JSONEncoding.default)

        case let .userReject(_, uuid):
            return .requestParameters(parameters: [
                "uuid": "\(uuid)"
            ], encoding: JSONEncoding.default)
        }
    }

    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }

    var errorMapper: [Int: Error]? {
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
                403: ClubApplicantError.alreadyClubMemberOrSameTypeClub,
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
                404: ClubApplicantError.notFoundAcceptUserOrClub,
                500: ClubApplicantError.serverError
            ]

        case .userReject:
            return[
                400: ClubApplicantError.bodyIsNull,
                401: ClubApplicantError.unauthorized,
                403: ClubApplicantError.notClubHead,
                404: ClubApplicantError.notFoundRejectUserOrClub,
                500: ClubApplicantError.serverError
            ]
        }
    }
}
