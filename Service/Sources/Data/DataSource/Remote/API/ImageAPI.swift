import Moya
import Foundation

enum ImageAPI {
    case uploadImage(Data)
}

extension ImageAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .image
    }
    var urlPath: String {
        switch self {
        case .uploadImage:
            return "/upload/picture"
        }
    }
    var method: Moya.Method {
        switch self {
        case .uploadImage:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .uploadImage(data):
            let multipart = MultipartFormData(
                provider: .data(data),
                name: "\(UUID().uuidString).png",
                fileName: "\(UUID().uuidString).png"
            )
            return .uploadMultipart([multipart])
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .uploadImage:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
