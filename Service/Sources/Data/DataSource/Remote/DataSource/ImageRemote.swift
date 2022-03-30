import RxSwift
 import Foundation

 final class ImageRemote: BaseRemote<ImageAPI> {
     static let shared = ImageRemote()
     private override init() {}
     func uploadPictures(datas: [Data]) -> Single<[String]> {
         return request(.uploadImages(datas))
             .map([String].self)
     }
 }
