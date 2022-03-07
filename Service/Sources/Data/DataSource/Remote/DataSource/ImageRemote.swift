import RxSwift
import Foundation

final class ImageRemote: BaseRemote<ImageAPI> {
    static let shared = ImageRemote()
    private override init() {}
    func uploadPicture(data: Data, isTest: Bool = false) -> Single<String> {
        return request(.uploadImage(data), isTest: isTest)
            .map(String.self)
    }
    func uploadPictures(datas: [Data], isTest: Bool = false) -> Single<[String]> {
        return request(.uploadImages(datas), isTest: isTest)
            .map([String].self)
    }
}
