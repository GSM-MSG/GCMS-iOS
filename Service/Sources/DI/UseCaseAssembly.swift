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
        container.register(CreateNewClubUseCase.self) { r in
             CreateNewClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(DeleteClubUseCase.self) { r in
             DeleteClubUseCase(
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
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(FetchClubApplicantUseCase.self) { r in
             FetchClubApplicantUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(FetchDetailClubUseCase.self) { r in
             FetchDetailClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(UserAcceptUseCase.self) { r in
             UserAcceptUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(UserRejectUseCase.self) { r in
             UserRejectUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(UserKickUseCase.self) { r in
             UserKickUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(ClubApplyUseCase.self) { r in
             ClubApplyUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(ClubCancelUseCase.self) { r in
             ClubCancelUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(ClubDelegationUseCase.self) { r in
             ClubDelegationUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
            )
        }
        container.register(UpdateClubUseCase.self) { r in
            UpdateClubUseCase(
                clubRepository: r.resolve(ClubRepository.self)!
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
        container.register(ClubExitUseCase.self) { r in
             ClubExitUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        container.register(WithdrawalUseCase.self) { r in
            WithdrawalUseCase(
                userRepository: r.resolve(UserRepository.self)!
            )
        }
        
        // MARK: - Image
        container.register(UploadImagesUseCase.self) { r in
             UploadImagesUseCase(
                imageRepository: r.resolve(ImageRepository.self)!
            )
        }
        // MARK: - Guest
        container.register(FetchGuestClubListUseCase.self) { r in
            FetchGuestClubListUseCase(
                guestRepository: r.resolve(GuestRepository.self)!
            )
        }
        container.register(FetchGuestDeatilClubUseCase.self) { r in
            FetchGuestDeatilClubUseCase(
                guestRepository: r.resolve(GuestRepository.self)!
            )
        }
        container.register(IssueGuestTokenUseCase.self) { r in
            IssueGuestTokenUseCase(
                guestRepository: r.resolve(GuestRepository.self)!
            )
        }
        container.register(RevokeGuestTokenUseCase.self) { r in
            RevokeGuestTokenUseCase(
                guestRepository: r.resolve(GuestRepository.self)!
            )
        }
    }
}
