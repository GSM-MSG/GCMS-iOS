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
                fetchClubListsUseCase: r.resolve(FetchClubListUseCase.self)!
            )
        }
        
        container.register(DetailClubReactor.self) { r, query in
             DetailClubReactor(
                query: query,
                deleteClubUseCase: r.resolve(DeleteClubUseCase.self)!,
                fetchDetailClubUseCase: r.resolve(FetchDetailClubUseCase.self)!
            )
        }
        
        container.register(MyPageReactor.self) { r in
             MyPageReactor(
                logoutUseCase: r.resolve(LogoutUseCase.self)!,
                fetchProfileUseCase: r.resolve(FetchProfileUseCase.self)!,
                uploadImagesUseCase: r.resolve(UploadImagesUseCase.self)!
            )
        }
        
        container.register(LoginReactor.self) { r in
             LoginReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }
        
        container.register(SignUpReactor.self) { r in
             SignUpReactor(
                sendVerifyUseCase: r.resolve(SendVerifyUseCase.self)!,
                registerUseCase: r.resolve(RegisterUseCase.self)!
            )
        }
        
        container.register(CertificationReactor.self) { r, email in
             CertificationReactor(
                checkIsVerifiedUseCase: r.resolve(CheckIsVerifiedUseCase.self)!,
                email: email
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
        
        container.register(ClubStatusReactor.self) { r, query in
             ClubStatusReactor(
                query: query,
                clubOpenUseCase: r.resolve(ClubOpenUseCase.self)!,
                clubCloseUseCase: r.resolve(ClubCloseUseCase.self)!,
                fetchClubMemberUseCase: r.resolve(FetchClubMemberUseCase.self)!,
                fetchClubApplicantUseCase: r.resolve(FetchClubApplicantUseCase.self)!,
                userAcceptUseCase: r.resolve(UserAcceptUseCase.self)!,
                userRejectUseCase: r.resolve(UserRejectUseCase.self)!,
                clubDelegationUseCase: r.resolve(ClubDelegationUseCase.self)!,
                userKickUseCase: r.resolve(UserKickUseCase.self)!
            )
        }
        
        container.register(UpdateClubReactor.self) { r, club in
             UpdateClubReactor(
                club: club,
                updateClubUseCase: r.resolve(UpdateClubUseCase.self)!,
                uploadImagesUseCase: r.resolve(UploadImagesUseCase.self)!
            )
        }
    }
}
