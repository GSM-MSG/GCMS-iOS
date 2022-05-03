import RxSwift
import Foundation

public struct UploadImagesUseCase {
    public init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    private let imageRepository: ImageRepository
    
    public func execute(images: [Data]) -> Single<[String]> {
        imageRepository.uploadImages(datas: images)
    }
}
