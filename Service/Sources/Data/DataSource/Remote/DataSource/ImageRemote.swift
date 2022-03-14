import RxSwift
 import Foundation

 final class ImageRemote: BaseRemote<ImageAPI> {
     static let shared = ImageRemote()
     private override init() {}
     func uploadPictures(datas: [Data], isTest: Bool = false) -> Single<[String]> {
         return request(.uploadImages(datas), isTest: isTest)
             .map([String].self)
     }
 }
