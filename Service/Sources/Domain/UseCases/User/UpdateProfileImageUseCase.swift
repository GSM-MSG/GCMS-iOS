import RxSwift

public final class UpdateProfileImageUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public let userRepository: UserRepository
    
    public func execute(imageUrl: String) -> Completable {
        userRepository.updateProfileImage(imageUrl: imageUrl)
    }
}
