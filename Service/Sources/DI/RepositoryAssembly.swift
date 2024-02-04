import Swinject

public final class RepositoryAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(AuthRepository.self) { r in
            DefaultAuthRepository(
                authRemote: r.resolve(AuthRemoteProtocol.self)!,
                keychainLocal: r.resolve(KeychainLocalProtocol.self)!
            )
        }
        container.register(ClubRepository.self) { r in
            DefaultClubRepository(
                clubRemote: r.resolve(ClubRemoteProtocol.self)!,
                clubLocal: r.resolve(ClubLocalProtocol.self)!
            )
        }
        container.register(UserRepository.self) { r in
            DefaultUserRepository(userRemote: r.resolve(UserRemoteProtocol.self)!)
        }
        container.register(ImageRepository.self) { r in
            DefaultImageRepository(imageRemote: r.resolve(ImageRemoteProtocol.self)!)
        }
        container.register(ClubApplicantRepository.self) { r in
            DefaultClubApplicantRepository(clubApplicantRemote: r.resolve(ClubApplicantRemoteProtocol.self)!)
        }
        container.register(ClubMemberRepository.self) { r in
            DefaultClubMemberRepository(clubMemberRemote: r.resolve(ClubMemberRemoteProtocol.self)!)
        }
    }
}
