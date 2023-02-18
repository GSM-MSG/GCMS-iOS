import Swinject

public final class RepositoryAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AuthRepository.self) { _ in DefaultAuthRepository() }
        container.register(ClubRepository.self) { _ in DefaultClubRepository() }
        container.register(ImageRepository.self) { _ in DefaultImageRepository() }
        container.register(UserRepository.self) { _ in DefaultUserRepository() }
        container.register(ClubApplicantRepository.self) { _ in DefaultClubApplicantRepository() }
        container.register(ClubMemberRepository.self) { _ in DefaultClubMemberRepository() }
    }
}
