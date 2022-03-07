import RxSwift
import Foundation

final class ImageRemote: BaseRemote<ImageAPI> {
    static let shared = ImageRemote()
    func updatePicture(data: Data, isTest: Bool = false) -> Single<String> {
        return request(.uploadImage(data), isTest: isTest)
            .map(String.self)
    }
}
