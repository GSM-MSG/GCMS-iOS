import Swinject
import Service

final class ReactorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingReactor.self) { r in
             OnBoardingReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }

        container.register(HomeReactor.self) { r in
             HomeReactor(
                fetchClubListsUseCase: r.resolve(FetchClubListUseCase.self)!,
                fetchMiniProfileUseCase: r.resolve(FetchMiniProfileUseCase.self)!
            )
        }

        container.register(DetailClubReactor.self) { (r: Resolver, clubID: Int) in
             DetailClubReactor(
                clubID: clubID,
                fetchDetailClubUseCase: r.resolve(FetchDetailClubUseCase.self)!,
                exitClubUseCase: r.resolve(ExitClubUseCase.self)!,
                clubApplyUseCase: r.resolve(ClubApplyUseCase.self)!,
                clubCancelUseCase: r.resolve(ClubCancelUseCase.self)!,
                clubOpenUseCase: r.resolve(ClubOpenUseCase.self)!,
                clubCloseUseCase: r.resolve(ClubCloseUseCase.self)!
            )
        }

        container.register(MyPageReactor.self) { r in
            MyPageReactor(
                logoutUseCase: r.resolve(LogoutUseCase.self)!,
                fetchProfileUseCase: r.resolve(FetchProfileUseCase.self)!,
                uploadImagesUseCase: r.resolve(UploadImagesUseCase.self)!,
                updateProfileImageUseCase: r.resolve(UpdateProfileImageUseCase.self)!,
                withdrawalUseCase: r.resolve(WithdrawalUseCase.self)!
            )
        }

        container.register(ClubMemberReactor.self) { r, clubID, isOpened in
            ClubMemberReactor(
                clubID: clubID,
                isOpened: isOpened,
                fetchClubMemberUseCase: r.resolve(FetchClubMemberUseCase.self)!,
                fetchClubApplicantUseCase: r.resolve(FetchClubApplicantUseCase.self)!,
                userKickUseCase: r.resolve(UserKickUseCase.self)!,
                clubDelegationUseCase: r.resolve(ClubDelegationUseCase.self)!,
                userAcceptUseCase: r.resolve(UserAcceptUseCase.self)!,
                userRejectUseCase: r.resolve(UserRejectUseCase.self)!,
                clubOpenUseCase: r.resolve(ClubOpenUseCase.self)!,
                clubCloseUseCase: r.resolve(ClubCloseUseCase.self)!
            )
        }
    }
}
