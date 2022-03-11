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
        self.register(LoginUseCase.self) { r in
            return LoginUseCase(
                authRepository: r.resolve(AuthRepository.self)
            )
        }
        self.register(AcceptClubUseCase.self) { r in
            return AcceptClubUseCase(
                userRepository: r.resolve(UserRepository.self)
            )
        }
    }
}
