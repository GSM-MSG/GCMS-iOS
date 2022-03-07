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
    
    func execute(data: Data, isTest: Bool = false) -> Completable {
        return imageRepository.uploadPicture(data: data, isTest: isTest)
            .flatMapCompletable { url in
                return self.userRepository.editProfile(url: url, isTest: isTest)
            }
    }
}
