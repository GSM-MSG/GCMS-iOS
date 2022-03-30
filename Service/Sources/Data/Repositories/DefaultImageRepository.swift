import RxSwift
import Foundation

final class DefaultImageRepository: ImageRepository {
    private let imageRemote = ImageRemote.shared
    func uploadPictures(datas: [Data]) -> Single<[String]> {
        imageRemote.uploadPictures(datas: datas)
    }
}
