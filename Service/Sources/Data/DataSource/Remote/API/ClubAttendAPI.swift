import Moya
import Foundation

enum ClubAttendAPI {
    case fetchAttendList(clubID: Int, date: String?, period: Period?)
    case createAttendance(clubID: Int, name: String, date: String, period: [Period])
    case changeAttendStatus(attendanceID: String, attendanceStatus: AttendanceStatus)
    case changeAllAttendStatus(attendanceIDs: [String], attendanceStatus: AttendanceStatus)
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

        case .changeAttendStatus(_, _):
            return ""

        case .changeAllAttendStatus(_, _):
            return "/batch"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchAttendList:
            return .get

        case .changeAttendStatus, .changeAllAttendStatus:
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
            return .requestParameters(parameters: [
                "name": "\(name)",
                "date": "\(date)",
                "period": "\(period)"
            ], encoding: JSONEncoding.default)
            
        case let .changeAttendStatus(attendanceID, attendanceStatus):
            return .requestParameters(parameters: [
                "attendanceID": "\(attendanceID)",
                "attendanceStatus": "\(attendanceStatus)"
            ], encoding: JSONEncoding.default)
            
        case let .changeAllAttendStatus(attendanceIDs, attendanceStatus):
            return .requestParameters(parameters: [
                "attendanceID": "\(attendanceIDs)",
                "attendanceStatus": "\(attendanceStatus)"
            ], encoding: JSONEncoding.default)
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
            
        case .changeAllAttendStatus:
            return [
                401: .unauthorized,
                403: .notClubHeadOrClubTeacher,
                404: .notFoundClub,
                500: .serverError
            ]
            
        case .createAttendance:
            return [:]

        case .changeAttendStatus:
            return [:]
        }
    }
}
