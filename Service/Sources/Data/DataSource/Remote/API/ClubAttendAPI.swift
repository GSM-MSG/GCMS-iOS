import Moya
import Foundation

enum ClubAttendAPI {
    case fetchAttendList(clubID: Int, date: String?, period: Period?)
    case createAttendance(clubID: Int)
    case recordeExcelPrint
    case changeAttendStatus
    case statusAllApply
}

extension ClubAttendAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .attend
    }

    var urlPath: String {
        switch self {
        case let .fetchAttendList(clubID, _, _):
            return "/\(clubID)"

        case let .createAttendance(clubID):
            return "/\(clubID)/club"

        case .recordeExcelPrint:
            return "/attend/excel"

        case .changeAttendStatus:
            return ""

        case .statusAllApply:
            return "/batch"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchAttendList, .recordeExcelPrint:
            return .get

        case .changeAttendStatus, .statusAllApply:
            return .patch

        case .createAttendance:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .fetchAttendList(_, date, period):
            return .requestParameters(parameters: [
                "date": date,
                "period": period
            ], encoding: URLEncoding.queryString)

        case .createAttendance,
             .recordeExcelPrint,
             .changeAttendStatus,
             .statusAllApply:
            return .requestPlain
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
        case .fetchAttendList, .recordeExcelPrint, .statusAllApply:
            return [
                400: .invalidInput,
                401: .unauthorized,
                403: .notExistUser,
                404: .notFoundClub,
                500: .serverError
            ]

        case .createAttendance:
            return [:]

        case .changeAttendStatus                              :
            return [:]
        }
    }
}
