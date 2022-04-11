import Swinject

public extension Container {
    func registerServiceDependencies() {
        registerRepositories()
        registerUseCase()
    }
    
    private func registerRepositories() {
        self.register(AuthRepository.self) { _ in DefaultAuthRepository() }
        self.register(ClubRepository.self) { _ in DefaultClubRepository() }
        self.register(ImageRepository.self) { _ in DefaultImageRepository() }
        self.register(UserRepository.self) { _ in DefaultUserRepository() }
    }
    private func registerUseCase() {
        // MARK: Auth
        self.register(LoginUseCase.self) { r in
            return LoginUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        self.register(RegisterUseCase.self) { r in
            return RegisterUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        self.register(CheckIsLoginedUseCase.self) { r in
            return CheckIsLoginedUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        self.register(SendVerifyUseCase.self) { r in
            return SendVerifyUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        self.register(CheckIsVerifiedUseCase.self) { r in
            return CheckIsVerifiedUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        self.register(LogoutUseCase.self) { r in
            return LogoutUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        // MARK: User
        
        // MARK: Club
    }
}
