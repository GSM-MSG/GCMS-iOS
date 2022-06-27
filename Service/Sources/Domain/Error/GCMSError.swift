import Foundation

public enum GCMSError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    
    case noInternet
    //MARK: - 400
    case invalidToken
    case clubTypeError
    case invalidInput
    // MARK: - 401
    case unauthorized
    // MARK: - 403
    // MARK: Login
    case notGSMAccount
    // MARK: Club
    case notClubHead
    case canNotKickHead
    // MARK: User
    case canNotLeaveTheClub
    case notExistUser
    // MARK: - 404
    // MARK: Login
    case notFoundInGSM
    case notFoundInEmail
    // MARK: Club
    case notFoundClub
    case notFoundUser
    case notFoundInApplyUser
    // MARK: - 406
    // MARK: Club
    case notExistInClub
    // MARK: - 409
    // MARK: Club
    case alreadyExistClub
    case belongOtherClub
    case belongClub
    case appliedToAnotherClub
}

extension GCMSError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error, .invalidToken, .unauthorized, .clubTypeError, .notFoundUser, .notExistUser, .invalidInput:
            return "알수없는 에러가 발생했습니다"
        case .noInternet:
            return "인터넷 연결이 원활하지 않습니다"
        // MARK: - 403
        case .notGSMAccount:
            return "GSM계정이 아닙니다"
        case .notClubHead:
            return "동아리 부장이 아니면 수정할 수 없습니다"
        case .canNotKickHead:
            return "부장은 자기자신을 강퇴할 수 없습니다"
        case .canNotLeaveTheClub:
            return "부장은 동아리를 탈퇴 할 수 없습니다"
        // MARK: - 404
        case .notFoundInGSM:
            return "GSM학생이 아닙니다"
        case .notFoundInEmail:
            return "이메일이 올바르지 않습니다"
        case .notFoundClub:
            return "동아리를 찾을 수 없습니다"
        case .notFoundInApplyUser:
            return "유저를 찾을 수 없습니다"
        // MARK: - 406
        case .notExistInClub:
            return "동아리에 속해있지 않습니다"
        // MARK: - 409
        case .alreadyExistClub:
            return "이미 존재하는 동아리입니다"
        case .belongOtherClub:
            return "다른 동아리에 소속되어있습니다"
        case .belongClub:
            return "이미 동아리에 속해있습니다"
        case .appliedToAnotherClub:
            return "이미 다른 동아리에 신청했습니다"
        }
    }
}
