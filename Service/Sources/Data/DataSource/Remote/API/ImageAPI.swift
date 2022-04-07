import Moya
import Foundation

enum ImageAPI {
    case uploadImages([Data])
}

extension ImageAPI: GCMSAPI {
    
    var domain: GCMSDomain {
        return .image
    }
    var urlPath: String {
        switch self {
        case .uploadImages:
            return "/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .uploadImages:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .uploadImages(datas):
            let multiparts = datas.map { data -> MultipartFormData in
                let uuid = UUID().uuidString
                return MultipartFormData(
                    provider: .data(data),
                    name: uuid,
                    fileName: "\(uuid).png"
                )
            }
            return .uploadMultipart(multiparts)
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .uploadImages:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
    
    var errorMapper: [Int: GCMSError]?{
        return [
            403: .Forbidden,
            409: .conflict
        ]
    }
}
