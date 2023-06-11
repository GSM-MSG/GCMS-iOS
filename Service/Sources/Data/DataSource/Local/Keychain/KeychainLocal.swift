import Foundation

protocol KeychainLocalProtocol {
    func saveAccessToken(_ token: String)
    func fetchAccessToken() throws -> String
    func deleteAccessToken()
    func saveRefreshToken(_ token: String)
    func fetchRefreshToken() throws -> String
    func deleteRefreshToken()
    func saveAccessExp(_ date: String)
    func fetchAccessExp() throws -> String
    func deleteAccessExp()
    func saveRefreshExp(_ date: String)
    func fetchRefreshExp() throws -> String
    func deleteRefreshExp()
}

final class KeychainLocal: KeychainLocalProtocol {
    private let keychain = Keychain()
    public init() {}

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

    func saveAccessExp(_ date: String) {
        keychain.save(type: .expiredAt, value: date)
    }

    func fetchAccessExp() throws -> String {
        return try keychain.load(type: .expiredAt)
    }

    func deleteAccessExp() {
        keychain.delete(type: .expiredAt)
    }

    func saveRefreshExp(_ date: String) {
        keychain.save(type: .expiredAt, value: date)
    }

    func fetchRefreshExp() throws -> String {
        return try keychain.load(type: .expiredAt)
    }

    func deleteRefreshExp() {
        keychain.delete(type: .expiredAt)
    }
}
