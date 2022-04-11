import Foundation

public enum GCMSError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    
    case noInternet
    case conflict
    case forbidden
}
