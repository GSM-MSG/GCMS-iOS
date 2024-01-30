import Swinject

public final class DataSourceAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeychainLocalProtocol.self) { _ in
            KeychainLocal()
        }

        container.register(RealmTaskType.self) { _ in
            RealmTask()
        }

        container.register(AuthRemoteProtocol.self) { r in
            AuthRemote(keychainLocal: r.resolve(KeychainLocalProtocol.self)!)
        }

        container.register(ClubLocalProtocol.self) { r in
            ClubLocal(realmTask: r.resolve(RealmTaskType.self)!)
        }

        container.register(ClubApplicantRemoteProtocol.self) { r in
            ClubApplicantRemote(keychainLocal: r.resolve(KeychainLocalProtocol.self)!)
        }

        container.register(ClubMemberRemoteProtocol.self) { r in
            ClubMemberRemote(keychainLocal: r.resolve(KeychainLocalProtocol.self)!)
        }

        container.register(ClubRemoteProtocol.self) { r in
            ClubRemote(keychainLocal: r.resolve(KeychainLocalProtocol.self)!)
        }

        container.register(UserRemoteProtocol.self) { r in
            UserRemote(keychainLocal: r.resolve(KeychainLocalProtocol.self)!)
        }
    }
}
