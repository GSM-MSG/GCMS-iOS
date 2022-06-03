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
                fetchGuestClubListUseCase: r.resolve(FetchGuestClubListUseCase.self)!
            )
        }
        
        container.register(DetailClubReactor.self) { r, query in
             DetailClubReactor(
                query: query,
                deleteClubUseCase: r.resolve(DeleteClubUseCase.self)!,
                fetchDetailClubUseCase: r.resolve(FetchDetailClubUseCase.self)!,
                fetchGuestDetailClubUseCase: r.resolve(FetchGuestDeatilClubUseCase.self)!,
                clubExitUseCase: r.resolve(ClubExitUseCase.self)!,
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
        
        container.register(NewClubReactor.self) { r in
             NewClubReactor(
                createNewClubUseCase: r.resolve(CreateNewClubUseCase.self)!,
                uploadImagesUseCase: r.resolve(UploadImagesUseCase.self)!
            )
        }
        
        container.register(MemberAppendReactor.self) { r, closure, clubType in
             MemberAppendReactor(
                closure: closure,
                clubType: clubType,
                searchUserUseCase: r.resolve(SearchUserUseCase.self)!
            )
        }
        
        container.register(ClubMemberReactor.self) { r, query, isOpened in
            ClubMemberReactor(
                query: query,
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
        
        container.register(UpdateClubReactor.self) { r, club in
             UpdateClubReactor(
                club: club,
                updateClubUseCase: r.resolve(UpdateClubUseCase.self)!,
                uploadImagesUseCase: r.resolve(UploadImagesUseCase.self)!
            )
        }
        
        container.register(AfterSchoolReactor.self) { r in
            AfterSchoolReactor()
        }
        
        container.register(SearchFilterReactor.self) { r in
            SearchFilterReactor()
        }
    }
}
