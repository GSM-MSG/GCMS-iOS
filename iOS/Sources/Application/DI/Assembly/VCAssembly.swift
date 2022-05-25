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
        
        container.register(FirstNewClubVC.self) { r in
            FirstNewClubVC(reactor: r.resolve(NewClubReactor.self))
        }
        
        container.register(SecondNewClubVC.self) { _, reactor in
            SecondNewClubVC(reactor: reactor)
        }
        
        container.register(ThirdNewClubVC.self) { _, reactor in
            ThirdNewClubVC(reactor: reactor)
        }
        container.register(AfterSchoolVC.self) { r in
            AfterSchoolVC(reactor: r.resolve(AfterSchoolReactor.self))
        }
        container.register(SearchFilterVC.self) { r in
            SearchFilterVC(reactor: r.resolve(SearchFilterReactor.self))
        }
    }
}
