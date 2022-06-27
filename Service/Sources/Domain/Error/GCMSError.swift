import Foundation

public enum GCMSError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    
    case noInternet
    //MARK: - 400
    case invalidToken
    case clubTypeError
    //MARK: - 401
    case unauthorized
    //MARK: - 403
    //MARK: Login
    case notGSMAccount
    //MARK: - 404
    //MARK: Login
    case notFoundInGSM
    case notFoundEmail
}

extension GCMSError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error, .invalidToken, .unauthorized, .clubTypeError:
            return "알수없는 에러가 발생했습니다"
        case .noInternet:
            return "인터넷 연결이 원활하지 않습니다"
        //MARK: - 403
        case .notGSMAccount:
            return "GSM계정이 아닙니다"
        //MARK: - 404
        case .notFoundInGSM:
            return "GSM학생이 아닙니다"
        case .notFoundEmail:
            return "이메일이 올바르지 않습니다"
        }
    }
}
