import RxSwift
import Foundation

public final class EditProfileUseCase {
    public init(
        userRepository: UserRepository,
        imageRepository: ImageRepository
    ) {
        self.userRepository = userRepository
        self.imageRepository = imageRepository
    }
    
    private let userRepository: UserRepository
    private let imageRepository: ImageRepository
    
    public func execute(data: Data, isTest: Bool = false) -> Completable {
        imageRepository.uploadPictures(datas: [data], isTest: isTest)
            .map { $0.first }
            .flatMapCompletable { url in
                return self.userRepository.editProfile(url: url ?? "", isTest: isTest)
            }
    }
}
