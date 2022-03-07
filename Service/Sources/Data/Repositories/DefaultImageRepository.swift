import RxSwift
import Foundation

final class DefaultImageRepository: ImageRepository {
    private let imageRemote = ImageRemote.shared
    func uploadPicture(data: Data, isTest: Bool = false) -> Single<String> {
        imageRemote.updatePicture(data: data, isTest: isTest)
    }
}
