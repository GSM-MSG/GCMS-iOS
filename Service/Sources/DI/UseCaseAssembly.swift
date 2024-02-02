import Swinject

public final class UseCaseAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        // MARK: - Auth
        container.register(LoginUseCase.self) { r in
             LoginUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        container.register(CheckIsLoginedUseCase.self) { r in
             CheckIsLoginedUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }
        container.register(LogoutUseCase.self) { r in
             LogoutUseCase(
                authRepository: r.resolve(AuthRepository.self)!
            )
        }

        // MARK: - Club
        container.register(ClubOpenUseCase.self) { r in
             ClubOpenUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(ClubCloseUseCase.self) { r in
             ClubCloseUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(FetchClubListUseCase.self) { r in
             FetchClubListUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(FetchClubMemberUseCase.self) { r in
             FetchClubMemberUseCase(
                clubMemberRepository: r.resolve(ClubMemberRepository.self)!
            )
        }
        container.register(FetchClubApplicantUseCase.self) { r in
             FetchClubApplicantUseCase(
                clubApplicantRepository: r.resolve(ClubApplicantRepository.self)!
            )
        }
        container.register(FetchDetailClubUseCase.self) { r in
             FetchDetailClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(ExitClubUseCase.self) { r in
            ExitClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(UserAcceptUseCase.self) { r in
             UserAcceptUseCase(
                clubApplicantRepository: r.resolve(ClubApplicantRepository.self)!
            )
        }
        container.register(UserRejectUseCase.self) { r in
             UserRejectUseCase(
                clubApplicantRepository: r.resolve(ClubApplicantRepository.self)!
            )
        }
        container.register(UserKickUseCase.self) { r in
             UserKickUseCase(
                clubMemberRepository: r.resolve(ClubMemberRepository.self)!
            )
        }
        container.register(ClubApplyUseCase.self) { r in
             ClubApplyUseCase(
                clubApplicantRepository: r.resolve(ClubApplicantRepository.self)!
            )
        }
        container.register(ClubCancelUseCase.self) { r in
             ClubCancelUseCase(
                clubApplicantRepository: r.resolve(ClubApplicantRepository.self)!
            )
        }
        container.register(ClubDelegationUseCase.self) { r in
             ClubDelegationUseCase(
                clubMemberRepository: r.resolve(ClubMemberRepository.self)!
            )
        }

        // MARK: - User
        container.register(FetchProfileUseCase.self) { r in
             FetchProfileUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        container.register(UpdateProfileImageUseCase.self) { r in
             UpdateProfileImageUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        container.register(SearchUserUseCase.self) { r in
             SearchUserUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        container.register(WithdrawalUseCase.self) { r in
            WithdrawalUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        container.register(FetchMiniProfileUseCase.self) { r in
            FetchMiniProfileUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
    }
}
