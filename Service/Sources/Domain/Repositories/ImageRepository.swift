import RxSwift
import Foundation

public protocol ImageRepository {
    func uploadPicture(data: Data, isTest: Bool) -> Single<String>
    func uploadPictures(datas: [Data], isTest: Bool) -> Single<[String]>
}
