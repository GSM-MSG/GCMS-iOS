import Foundation

public enum GCMSError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    
    case noInternet
    //MARK: - 400
    case invalidToken
    case clubTypeError
    case invalidInput
    case noMebmerClub
    case failedAppleLogin
    
    // MARK: - 401
    case unauthorized
    
    // MARK: - 403
    // MARK: Login
    case notGSMAccount
    // MARK: Club
    case notClubHead
    case canNotKickHeadOrNotClubHead
    // MARK: User
    case canNotLeaveTheClub
    case notExistUser
    
    // MARK: - 404
    // MARK: Login
    case notFoundInGSMOrEmail
    // MARK: Club
    case notFoundClub
    case notFoundUser
    case notFoundInApplyUserOrNotFoundClub
    case notFoundUserOrNotFoundClub
    
    // MARK: - 406
    // MARK: Club
    case notExistInClub
    
    // MARK: - 409
    // MARK: Club
    case alreadyExistClubOrBelongOtherClub
    case belongOtherClubOrBelongClub
    case appliedToAnotherClubOrBelongClub
}

extension GCMSError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error, .invalidToken, .unauthorized, .clubTypeError, .notFoundUser, .notExistUser, .invalidInput, .noMebmerClub:
            return "알수없는 에러가 발생했습니다"
        case .noInternet:
            return "인터넷 연결이 원활하지 않습니다"
        case .failedAppleLogin:
            return "애플 로그인을 실패 했습니다\n 잠시 후 다시 시도 해주세요"
        // MARK: - 403
        case .notGSMAccount:
            return "*@gsm.hs.kr 계정이 아닙니다"
        case .notClubHead:
            return "동아리 부장이 아니면 수정할 수 없습니다"
        case .canNotKickHeadOrNotClubHead:
            return "부장이 아니거나 자기자신을 강퇴할 수 없습니다"
        case .canNotLeaveTheClub:
            return "부장은 동아리를 탈퇴 할 수 없습니다"
        // MARK: - 404
        case .notFoundInGSMOrEmail:
            return "GSM학생이 아니거나 이메일이 존재하지 않습니다"
        case .notFoundClub:
            return "동아리를 찾을 수 없습니다"
        case .notFoundInApplyUserOrNotFoundClub:
            return "동아리 또는 신청자가 존재하지 않습니다"
        case .notFoundUserOrNotFoundClub:
            return "동아리 또는 유저가 존재하지 않습니다"
        // MARK: - 406
        case .notExistInClub:
            return "동아리에 속해있지 않습니다"
        // MARK: - 409
        case .alreadyExistClubOrBelongOtherClub:
            return "이미 존재하는 동아리이거나 다른 동아리에 참여되어있습니다"
        case .belongOtherClubOrBelongClub:
            return "이미 소속되었거나 다른 동아리에 소속되어있습니다"
        case .appliedToAnotherClubOrBelongClub:
            return "이미 소속되어있거나 다른 동아리에 신청했습니다"
        }
    }
}
