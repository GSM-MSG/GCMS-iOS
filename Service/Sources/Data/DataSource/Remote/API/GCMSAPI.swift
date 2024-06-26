import Moya
import Foundation

protocol GCMSAPI: TargetType, JWTTokenAuthorizable {
    associatedtype ErrorType: Error
    var domain: GCMSDomain { get }
    var urlPath: String { get }
    var errorMapper: [Int: ErrorType]? { get }
}

extension GCMSAPI {
    var baseURL: URL {
        #if DEBUG
        return URL(
            string: Bundle.module.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        ) ?? URL(string: "https://www.google.com")!
        #else
        return URL(
            string: Bundle.module.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        ) ?? URL(string: "https://www.google.com")!
        #endif
    }
    var path: String {
        return domain.url + urlPath
    }
    var validationType: ValidationType {
        return .successCodes
    }
    var headers: [String: String]? {
        switch self {

        default:
            return ["Content-Type": "application/json"]
        }
    }
}

enum GCMSDomain: String {
    case image
    case auth
    case user
    case club
    case clubMember = "club-member"
    case applicant
    case attend
}

extension GCMSDomain {
    var url: String {
        return "/\(self.rawValue)"
    }
}

private class BundleFinder {}

extension Foundation.Bundle {
    static let module = Bundle(for: BundleFinder.self)
}
