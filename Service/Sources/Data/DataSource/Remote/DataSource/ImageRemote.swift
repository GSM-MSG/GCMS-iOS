import RxSwift
import Foundation

protocol ImageRemoteProtocol {
    func uploadPictures(datas: [Data]) -> Single<[String]>
}

 final class ImageRemote: BaseRemote<ImageAPI>, ImageRemoteProtocol {
     func uploadPictures(datas: [Data]) -> Single<[String]> {
         return request(.uploadImages(datas))
             .map(UploadImagesResponse.self)
             .map(\.images)
     }
 }
