import Moya
import Foundation

enum ClubMemberAPI {
    case clubMember(clubID: Int)
    case userKick(clubID: Int, uuid: UUID)
    case delegation(clubID: Int, uuid: UUID)
}

extension ClubMemberAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .clubMember
    }

    var urlPath: String {
        switch self {
        case let .clubMember(clubID), let .userKick(clubID, _), let .delegation(clubID, _):
            return "/\(clubID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .clubMember:
            return .get

        case .userKick:
            return .post

        case .delegation:
            return .patch
        }
    }

    var task: Moya.Task {
        switch self {
        case .clubMember:
            return .requestPlain

        case let .userKick(_, uuid):
            return .requestParameters(parameters: [
                "uuid": "\(uuid)"
            ], encoding: JSONEncoding.default)

        case let .delegation(_, uuid):
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

    typealias ErrorType = ClubMemberError
    var errorMapper: [Int: ClubMemberError]? {
        switch self {
        case .clubMember:
            return [
                401: .unauthorized,
                403: .notClubMember,
                404: .notFoundClub,
                500: .serverError
            ]

        case .userKick:
            return [
                400: .kickMyself,
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundClubOrKickUser,
                500: .serverError
            ]

        case .delegation:
            return [
                400: .delegationMyself,
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundClub,
                500: .serverError
            ]
        }
    }
}
