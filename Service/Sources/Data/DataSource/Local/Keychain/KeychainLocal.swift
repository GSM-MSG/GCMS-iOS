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
    
}
