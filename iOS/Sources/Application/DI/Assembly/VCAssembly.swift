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
            MyPageVC(reactor: r.resolve(MyPageReactor.self))
        }
    }
}
