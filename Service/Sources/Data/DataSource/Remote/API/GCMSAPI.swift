import Moya
import Foundation

protocol GCMSAPI: TargetType, JWTTokenAuthorizable {
    var domain: GCMSDomain { get }
    var urlPath: String { get }
}

extension GCMSAPI {
    var baseURL: URL {
        return URL(string: "")!
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
    case misc = ""
    case user
    case club
    case majorClub = "club/major"
    case editorialClub = "club/editorial"
    case freedomClub = "club/freedom"
}

extension GCMSDomain {
    var url: String {
        return "/\(self.rawValue)"
    }
}
