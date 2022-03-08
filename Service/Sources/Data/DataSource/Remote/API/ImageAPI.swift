import Moya
import Foundation

enum ImageAPI {
    case uploadImage(Data)
    case uploadImages([Data])
}

extension ImageAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .image
    }
    var urlPath: String {
        switch self {
        case .uploadImage:
            return "/upload/picture"
        case .uploadImages:
            return "/upload/pictures"
        }
    }
    var method: Moya.Method {
        switch self {
        case .uploadImage, .uploadImages:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .uploadImage(data):
            let uuid = UUID().uuidString
            let multipart = MultipartFormData(
                provider: .data(data),
                name: uuid,
                fileName: "\(uuid).png"
            )
            return .uploadMultipart([multipart])
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
        case .uploadImage, .uploadImages:
            return .accessToken
        default:
            return JWTTokenType.none
        }
    }
}
