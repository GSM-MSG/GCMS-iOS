import Swinject
import Service


final class ReactorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingReactor.self) { r in
            return OnBoardingReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }.inObjectScope(.container)
        
        container.register(HomeReactor.self) { r in
            return HomeReactor(
                
            )
        }.inObjectScope(.container)
        
        container.register(DetailClubReactor.self) { r, query in
            return DetailClubReactor(
                query: query,
                deleteClubUseCase: r.resolve(DeleteClubUseCase.self)!
            )
        }.inObjectScope(.container)
        
        container.register(MyPageReactor.self) { r in
            return MyPageReactor(
                logoutUseCase: r.resolve(LogoutUseCase.self)!
            )
        }.inObjectScope(.container)
        
        container.register(LoginReactor.self) { r in
            return LoginReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }.inObjectScope(.container)
        
        container.register(SignUpReactor.self) { r in
            return SignUpReactor(
                sendVerifyUseCase: r.resolve(SendVerifyUseCase.self)!,
                registerUseCase: r.resolve(RegisterUseCase.self)!
            )
        }.inObjectScope(.container)
        
        container.register(CertificationReactor.self) { r, email in
            return CertificationReactor(
                checkIsVerifiedUseCase: r.resolve(CheckIsVerifiedUseCase.self)!,
                email: email
            )
        }.inObjectScope(.container)
        
        container.register(NewClubReactor.self) { _ in
            return NewClubReactor()
        }.inObjectScope(.container)
        
        container.register(MemberAppendReactor.self) { _, closure in
            return MemberAppendReactor(closure: closure)
        }.inObjectScope(.container)
        
        container.register(ClubStatusReactor.self) { r, query in
            return ClubStatusReactor(
                query: query,
                clubOpenUseCase: r.resolve(ClubOpenUseCase.self)!,
                clubCloseUseCase: r.resolve(ClubCloseUseCase.self)!,
                fetchClubMemberUseCase: r.resolve(FetchClubMemberUseCase.self)!,
                fetchClubApplicantUseCase: r.resolve(FetchClubApplicantUseCase.self)!
            )
        }.inObjectScope(.container)
    }
}
