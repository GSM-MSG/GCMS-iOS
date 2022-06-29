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
    
    func deleteAccessToken() {
        keychain.delete(type: .accessToken)
    }
    
    func saveRefreshToken(_ token: String) {
        keychain.save(type: .refreshToken, value: token)
    }
    
    func fetchRefreshToken() throws -> String {
        return try keychain.load(type: .refreshToken)
    }
    
    func deleteRefreshToken() {
        keychain.delete(type: .refreshToken)
    }
    
    func saveExpiredAt(_ date: String) {
        keychain.save(type: .expiredAt, value: date)
    }
    
    func fetchExpiredAt() throws -> String {
        return try keychain.load(type: .expiredAt)
    }
    
    func deleteExpiredAt() {
        keychain.delete(type: .expiredAt)
    }
    
    func saveGuestRefreshToken(_ token: String) {
        keychain.save(type: .guestRefresh, value: token)
    }
    
    func fetchGuestRefreshToken() throws -> String {
        return try keychain.load(type: .guestRefresh)
    }
    
    func deleteGuestRefreshToken() {
        keychain.delete(type: .guestRefresh)
    }
}
