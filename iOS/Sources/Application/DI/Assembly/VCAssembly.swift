import Swinject

final class VCAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnBoardingVC.self) { r in
            OnBoardingVC(reactor: r.resolve(OnBoardingReactor.self))
        }.inObjectScope(.container)
        
        container.register(HomeVC.self) { r in
            let reactor = r.resolve(HomeReactor.self)
            let home = HomeVC(reactor: reactor)
            home.setViewControllers([
                MajorClubListVC(reactor: reactor),
                FreedomClubListVC(reactor: reactor),
                EditorialClubListVC(reactor: reactor)
            ])
            return home
        }.inObjectScope(.container)
        
        container.register(MyPageVC.self) { r in
            return MyPageVC(reactor: r.resolve(MyPageReactor.self))
        }.inObjectScope(.container)
        
        container.register(LoginVC.self) { r in
            return LoginVC(reactor: r.resolve(LoginReactor.self))
        }.inObjectScope(.container)
        
        container.register(SignUpVC.self) { r in
            return SignUpVC(reactor: r.resolve(SignUpReactor.self))
        }.inObjectScope(.container)
        
        container.register(FirstNewClubVC.self) { r in
            return FirstNewClubVC(reactor: r.resolve(NewClubReactor.self))
        }.inObjectScope(.container)
        
        container.register(SecondNewClubVC.self) { _, reactor in
            return SecondNewClubVC(reactor: reactor)
        }.inObjectScope(.container)
        
        container.register(ThirdNewClubVC.self) { _, reactor in
            return ThirdNewClubVC(reactor: reactor)
        }.inObjectScope(.container)
    }
}
