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
            return HomeVC(reactor: r.resolve(HomeReactor.self))
        }
        self.register(MyPageVC.self) { r in
            return MyPageVC(reactor: r.resolve(MyPageReactor.self))
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
    }
}
