import Swinject

public final class UseCaseAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        // MARK: - Auth
        container.register(LoginUseCase.self) { r in
            return LoginUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(RegisterUseCase.self) { r in
            return RegisterUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(CheckIsLoginedUseCase.self) { r in
            return CheckIsLoginedUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(SendVerifyUseCase.self) { r in
            return SendVerifyUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(CheckIsVerifiedUseCase.self) { r in
            return CheckIsVerifiedUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(LogoutUseCase.self) { r in
            return LogoutUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }.inObjectScope(.container)
        
        // MARK: - Club
        container.register(ClubOpenUseCase.self) { r in
            return ClubOpenUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(ClubCloseUseCase.self) { r in
            return ClubCloseUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(CreateNewClubUseCase.self) { r in
            return CreateNewClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(DeleteClubUseCase.self) { r in
            return DeleteClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(FetchClubLiseUseCase.self) { r in
            return FetchClubLiseUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(FetchClubMemberUseCase.self) { r in
            return FetchClubMemberUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(FetchClubApplicantUseCase.self) { r in
            return FetchClubApplicantUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(FetchDetailClubUseCase.self) { r in
            return FetchDetailClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(UserAcceptUseCase.self) { r in
            return UserAcceptUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(UserRejectUseCase.self) { r in
            return UserRejectUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(UserKickUseCase.self) { r in
            return UserKickUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }.inObjectScope(.container)
        
        // MARK: - User
        container.register(FetchProfileUseCase.self) { r in
            return FetchProfileUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(UpdateProfileImageUseCase.self) { r in
            return UpdateProfileImageUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }.inObjectScope(.container)
        
        container.register(SearchUserUseCase.self) { r in
            return SearchUserUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        
        container.register(ClubExitUseCase.self) { r in
            return ClubExitUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
    }
}
