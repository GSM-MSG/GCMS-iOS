import Foundation

public enum ClubAttendError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    
    // MARK: - 401
    case unauthorized
    
    // MARK: - 403
    case notClubMember
    case notClubHeadOrClubTeacher
    
    // MARK: - 404
    case notFoundClub
    
    // MARK: - 500
    case serverError
}

extension ClubAttendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .error(message, _):
            return message

        case .unauthorized, .serverError:
            return "알 수 없는 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."

        // MARK: - 403
        case .notClubMember:
            return "동아리 구성원이 아니면 사용할 수 없습니다."
            
        case .notClubHeadOrClubTeacher:
            return "동아리 부장이 아니거나 담당 선생님이 아니면 사용할 수 없습니다."
            
        // MARK: - 404
        case .notFoundClub:
            return "동아리를 찾을 수 없습니다."
        }
    }
}
