import Swinject
import Service


final class ReactorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingReactor.self) { r in
            return OnBoardingReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }
        
        container.register(HomeReactor.self) { r in
            return HomeReactor(
                fetchClubListsUseCase: r.resolve(FetchClubListUseCase.self)!
            )
        }
        
        container.register(DetailClubReactor.self) { r, query in
            return DetailClubReactor(
                query: query,
                deleteClubUseCase: r.resolve(DeleteClubUseCase.self)!,
                fetchDetailClubUseCase: r.resolve(FetchDetailClubUseCase.self)!
            )
        }
        
        container.register(MyPageReactor.self) { r in
            return MyPageReactor(
                logoutUseCase: r.resolve(LogoutUseCase.self)!
            )
        }
        
        container.register(LoginReactor.self) { r in
            return LoginReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }
        
        container.register(SignUpReactor.self) { r in
            return SignUpReactor(
                sendVerifyUseCase: r.resolve(SendVerifyUseCase.self)!,
                registerUseCase: r.resolve(RegisterUseCase.self)!
            )
        }
        
        container.register(CertificationReactor.self) { r, email in
            return CertificationReactor(
                checkIsVerifiedUseCase: r.resolve(CheckIsVerifiedUseCase.self)!,
                email: email
            )
        }
        
        container.register(NewClubReactor.self) { _ in
            return NewClubReactor()
        }
        
        container.register(MemberAppendReactor.self) { _, closure, clubType in
            return MemberAppendReactor(closure: closure, clubType: clubType)
        }
        
        container.register(ClubStatusReactor.self) { r, query in
            return ClubStatusReactor(
                query: query,
                clubOpenUseCase: r.resolve(ClubOpenUseCase.self)!,
                clubCloseUseCase: r.resolve(ClubCloseUseCase.self)!,
                fetchClubMemberUseCase: r.resolve(FetchClubMemberUseCase.self)!,
                fetchClubApplicantUseCase: r.resolve(FetchClubApplicantUseCase.self)!
            )
        }
        
        container.register(UpdateClubReactor.self) { r, club in
            return UpdateClubReactor(
                club: club
            )
        }
    }
}
