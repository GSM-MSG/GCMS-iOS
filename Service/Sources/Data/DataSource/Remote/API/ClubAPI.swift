import Moya

enum ClubAPI {
    case clubList(type: ClubType)
    case clubDetail(clubID: Int)
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
        case .clubList:
            return ""

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

    typealias ErrorType = GCMSError
    var errorMapper: [Int: GCMSError]? {
        switch self {
        case .clubList:
            return [
                400: .invalidInput,
                401: .unauthorized,
                500: .serverError
            ]

        case .clubDetail:
            return [
                401: .unauthorized,
                404: .notFoundUserOrNotFoundClub,
                500: .serverError
            ]

        case .updateClub:
            return [
                400: .invalidInput,
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundClub,
                500: .serverError
            ]

        case .deleteClub:
            return [
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundClub,
                500: .serverError
            ]

        case .clubOpen:
            return [
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundClub,
                500: .serverError
            ]

        case .clubClose:
            return [
                401: .unauthorized,
                403: .notClubHead,
                404: .notFoundClub,
                500: .serverError
            ]

        case .exitClub:
            return [
                400: .noMebmerClub,
                401: .unauthorized,
                404: .notFoundClub,
                500: .serverError
            ]
        }
    }
}
