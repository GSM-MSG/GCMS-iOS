import RxSwift
import Foundation

public protocol ImageRepository {
    func uploadImages(datas: [Data]) -> Single<[String]>
}
