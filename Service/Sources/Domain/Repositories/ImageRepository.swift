import RxSwift
import Foundation

public protocol ImageRepository {
    func uploadPictures(datas: [Data], isTest: Bool) -> Single<[String]>
}
