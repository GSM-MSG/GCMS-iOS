import Swinject
import RxFlow
import Service

extension Container{
    func registerDependencies() {
        registerVC()
        registerReactor()
    }
    
    private func registerVC() {
        self.register(OnBoardingVC.self) { r in
            return OnBoardingVC(reactor: r.resolve(OnBoardingReactor.self))
        }
        self.register(HomeVC.self) { r in
            let reactor = r.resolve(HomeReactor.self)
            let home = HomeVC(reactor: reactor)
            home.setViewControllers([
                MajorClubListVC(reactor: reactor),
                FreedomClubListVC(reactor: reactor),
                EditorialClubListVC(reactor: reactor)
            ])
            return home
        }
        self.register(MyPageVC.self) { r in
            return MyPageVC(reactor: r.resolve(MyPageReactor.self))
        }
        self.register(LoginVC.self) { r in
            return LoginVC(reactor: r.resolve(LoginReactor.self))
        }
        self.register(CertificationVC.self) { r in
            return CertificationVC(reactor: r.resolve(CertificationReactor.self))
        }
    }
    
    private func registerReactor() {
        self.register(OnBoardingReactor.self) { r in
            return OnBoardingReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }
        self.register(HomeReactor.self) { r in
            return HomeReactor(
                
            )
        }
        self.register(MyPageReactor.self) { r in
            return MyPageReactor(
                
            )
        }
        self.register(LoginReactor.self) { r in
            return LoginReactor(
                loginUseCase: r.resolve(LoginUseCase.self)!
            )
        }
        self.register(CertificationReactor.self) { r in
            return CertificationReactor(
            
            )
        }
    }
}
