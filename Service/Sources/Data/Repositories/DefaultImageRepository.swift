import RxSwift
import Foundation

final class DefaultImageRepository: ImageRepository {
    private let imageRemote: any ImageRemoteProtocol

    init(imageRemote: any ImageRemoteProtocol) {
        self.imageRemote = imageRemote
    }

    func uploadImages(datas: [Data]) -> Single<[String]> {
        imageRemote.uploadPictures(datas: datas)
    }
}
