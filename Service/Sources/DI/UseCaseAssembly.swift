import Swinject

public final class UseCaseAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
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
        
        container.register(FetchSearchUserUseCase.self) { r in
            return FetchSearchUserUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        
        container.register(ClubExitUseCase.self) { r in
            return ClubExitUseCase(userRepository: r.resolve(
                UserRepository.self)!
            )
        }
    }
}
