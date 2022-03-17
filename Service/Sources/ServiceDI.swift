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
        // MARK: User
        self.register(AcceptClubUseCase.self) { r in
            return AcceptClubUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        self.register(RejectClubUseCase.self) { r in
            return RejectClubUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        self.register(EditProfileUseCase.self) { r in
            return EditProfileUseCase(
                userRepository: r.resolve(UserRepository.self)!,
                imageRepository: r.resolve(ImageRepository.self)!
            )
        }
        self.register(FetchNoticeListUseCase.self) { r in
            return FetchNoticeListUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        self.register(FetchUserInfoUseCase.self) { r in
            return FetchUserInfoUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        self.register(SearchUserUseCase.self) { r in
            return SearchUserUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        // MARK: Club
        self.register(CreateNewClubUseCase.self) { r in
            return CreateNewClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!,
                imageRepository: r.resolve(ImageRepository.self)!
            )
        }
        self.register(FetchClubListUseCase.self) { r in
            return FetchClubListUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        self.register(FetchDetailClubUseCase.self) { r in
            return FetchDetailClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        self.register(FetchManagementClubUseCase.self) { r in
            return FetchManagementClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
    }
}
