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
        case let .applicantList(clubID), let .apply(clubID), let .cancel(clubID):
            return "/\(clubID)"

        case let .userAccept(clubID, _):
            return "/\(clubID)/accept"

        case let .userReject(clubID, _):
            return "/\(clubID)/reject"
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

    typealias ErrorType = ClubApplicantError
    var errorMapper: [Int: ClubApplicantError]? {
        switch self {
        case .applicantList:
            return[
                400: .notClubMember,
                401: .unauthorized,
                404: .notFoundClub,
                500: .serverError
            ]

        case .apply:
            return[
                401: .unauthorized,
                403: .alreadyClubMemberOrSameTypeClub,
                404: .notFoundClub,
                500: .serverError
            ]

        case .cancel:
            return[
                401: .unauthorized,
                404: .notFoundClub,
                500: .serverError
            ]

        case .userAccept:
            return[
                400: .bodyIsNull,
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundAcceptUserOrClub,
                500: .serverError
            ]

        case .userReject:
            return[
                400: .bodyIsNull,
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundRejectUserOrClub,
                500: .serverError
            ]
        }
    }
}
