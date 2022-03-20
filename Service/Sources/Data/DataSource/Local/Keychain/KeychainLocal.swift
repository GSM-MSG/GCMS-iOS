import Foundation

final class KeychainLocal {
    static let shared = KeychainLocal()
    private let keychain = Keychain()
    private init() {}
    
    func saveAccessToken(_ token: String) {
        keychain.save(type: .accessToken, value: token)
    }
    
    func fetchAccessToken() throws -> String {
        return try keychain.load(type: .accessToken)
    }
    
    func saveRefreshToken(_ token: String) {
        keychain.save(type: .refreshToken, value: token)
    }
    
    func fetchRefreshToken() throws -> String {
        return try keychain.load(type: .refreshToken)
    }
    
    func saveExpiredAt(_ date: String) {
        keychain.save(type: .expiredAt, value: date)
    }
    
    func fetchExpiredAt() throws -> String {
        return try keychain.load(type: .expiredAt)
    }
}
