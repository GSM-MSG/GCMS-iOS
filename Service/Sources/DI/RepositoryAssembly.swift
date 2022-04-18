import Swinject

public final class RepositoryAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AuthRepository.self) { _ in DefaultAuthRepository() }.inObjectScope(.container)
        container.register(ClubRepository.self) { _ in DefaultClubRepository() }.inObjectScope(.container)
        container.register(ImageRepository.self) { _ in DefaultImageRepository() }.inObjectScope(.container)
        container.register(UserRepository.self) { _ in DefaultUserRepository() }.inObjectScope(.container)
    }
}
