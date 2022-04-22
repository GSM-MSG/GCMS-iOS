import Swinject

final class VCAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingVC.self) { r in
            OnBoardingVC(reactor: r.resolve(OnBoardingReactor.self))
        }
        
        container.register(HomeVC.self) { r in
            let reactor = r.resolve(HomeReactor.self)
            let home = HomeVC(reactor: reactor)
            home.setViewControllers([
                MajorClubListVC(reactor: reactor),
                FreedomClubListVC(reactor: reactor),
                EditorialClubListVC(reactor: reactor)
            ])
            return home
        }
        
        container.register(MyPageVC.self) { r in
            return MyPageVC(reactor: r.resolve(MyPageReactor.self))
        }
        
        container.register(LoginVC.self) { r in
            return LoginVC(reactor: r.resolve(LoginReactor.self))
        }
        
        container.register(SignUpVC.self) { r in
            return SignUpVC(reactor: r.resolve(SignUpReactor.self))
        }
        
        container.register(FirstNewClubVC.self) { r in
            return FirstNewClubVC(reactor: r.resolve(NewClubReactor.self))
        }
        
        container.register(SecondNewClubVC.self) { _, reactor in
            return SecondNewClubVC(reactor: reactor)
        }
        
        container.register(ThirdNewClubVC.self) { _, reactor in
            return ThirdNewClubVC(reactor: reactor)
        }
    }
}
