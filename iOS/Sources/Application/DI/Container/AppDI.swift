import Swinject
import RxFlow

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
            return HomeVC(reactor: r.resolve(HomeReactor.self))
        }
        self.register(ManagementVC.self) { r in
            return ManagementVC(reactor: r.resolve(ManagementReactor.self))
        }
    }
    
    private func registerReactor() {
        self.register(OnBoardingReactor.self) { r in
            return OnBoardingReactor()
        }
        self.register(HomeReactor.self) { r in
            return HomeReactor()
        }
        self.register(ManagementReactor.self) { r in
            return ManagementReactor()
        }
    }
}
