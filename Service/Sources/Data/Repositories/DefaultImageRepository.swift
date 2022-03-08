import RxSwift
import Foundation

final class DefaultImageRepository: ImageRepository {
    private let imageRemote = ImageRemote.shared
    func uploadPicture(data: Data, isTest: Bool = false) -> Single<String> {
        imageRemote.uploadPicture(data: data, isTest: isTest)
    }
    func uploadPictures(datas: [Data], isTest: Bool) -> Single<[String]> {
        imageRemote.uploadPictures(datas: datas, isTest: isTest)
    }
}
