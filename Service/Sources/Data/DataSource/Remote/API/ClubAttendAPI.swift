import Moya
import Foundation

enum ClubAttendAPI {
    case fetchAttendList(clubID: Int, date: String?, period: Period?)
    case createAttendance(clubID: Int, name: String, date: String, period: [Period])
    case changeAllAttendStatus(attendanceID: String, attendanceStatus: AttendanceStatus)
    case statusAllApply(attendanceIDs: [String], attendanceStatus: AttendanceStatus)
}

extension ClubAttendAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .attend
    }

    var urlPath: String {
        switch self {
        case let .fetchAttendList(clubID, _, _):
            return "/\(clubID)"

        case let .createAttendance(clubID, _, _, _):
            return "/\(clubID)/club"

        case .changeAllAttendStatus(_, _):
            return ""

        case .statusAllApply(_, _):
            return "/batch"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchAttendList:
            return .get

        case .changeAllAttendStatus, .statusAllApply:
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

        case let .createAttendance(_, name, date, period):
            return .requestPlain
            
        case .changeAllAttendStatus(_, _):
            return .requestPlain
            
        case .statusAllApply(_, _):
            return .requestPlain
        }
    }

    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }

    typealias ErrorType = ClubAttendError
    var errorMapper: [Int: ClubAttendError]? {
        switch self {
        case .fetchAttendList:
            return [
                401: .unauthorized,
                403: .notClubMember,
                404: .notFoundClub,
                500: .serverError
            ]
            
        case .statusAllApply:
            return [
                401: .unauthorized,
                403: .notClubHeadOrClubTeacher,
                404: .notFoundClub,
                500: .serverError
            ]
            
        case .createAttendance:
            return [:]

        case .changeAllAttendStatus:
            return [:]
        }
    }
}
