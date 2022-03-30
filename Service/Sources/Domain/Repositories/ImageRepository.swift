import RxSwift
import Foundation

public protocol ImageRepository {
    func uploadPictures(datas: [Data]) -> Single<[String]>
}
