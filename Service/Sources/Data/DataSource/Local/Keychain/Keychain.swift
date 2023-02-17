import Foundation

enum KeychainAccountType: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
    case expiredAt = "EXPIRED-AT"
    case guestRefresh = "GUEST-REFRESH-TOKEN"
}
final class Keychain {
    static let shared = Keychain()

    private let service = Bundle.main.bundleIdentifier ?? ""

    func save(type: KeychainAccountType, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) ?? .init()
        ]
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }

    func load(type: KeychainAccountType) throws -> String {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataRef)
        if status == errSecSuccess {
            guard let data = dataRef as? Data else { throw KeychainError.noData }
            let value = String(data: data, encoding: .utf8)
            return value!
        } else {
            throw KeychainError.noData
        }
    }

    func delete(type: KeychainAccountType) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: type.rawValue
        ]
        SecItemDelete(query)
    }
}
