import RxSwift

public struct UpdateProfileImageUseCase {
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    private let userRepository: UserRepository

    public func execute(imageUrl: String) -> Completable {
        userRepository.updateProfileImage(imageUrl: imageUrl)
    }
}
