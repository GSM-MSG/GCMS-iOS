import Moya
import Foundation

protocol GCMSAPI: TargetType, JWTTokenAuthorizable {
    var domain: GCMSDomain { get }
    var urlPath: String { get }
    var errorMapper: [Int: GCMSError]? { get }
}

extension GCMSAPI {
    var baseURL: URL {
        return URL(string: "http://3.36.15.183:4000")!
    }
    var path: String {
        return domain.url + urlPath
    }
    var validationType: ValidationType {
        return .successCodes
    }
    var headers: [String : String]? {
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
    case guest
}

extension GCMSDomain {
    var url: String {
        return "/\(self.rawValue)"
    }
}
