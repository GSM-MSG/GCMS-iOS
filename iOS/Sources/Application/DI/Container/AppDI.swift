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
        self.register(AlarmVC.self) { r in
            return AlarmVC(reactor: r.resolve(AlarmReactor.self))
        }
        self.register(MyPageVC.self) { r in
            return MyPageVC(reactor: r.resolve(MyPageReactor.self))
        }
        self.register(ManagementVC.self) { r in
            return ManagementVC(reactor: r.resolve(ManagementReactor.self))
        }
        self.register(LoginVC.self) { r in
            return LoginVC(reactor: r.resolve(LoginReactor.self))
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
                fetchClubListUseCase: r.resolve(FetchClubListUseCase.self)!
            )
        }
        self.register(ManagementReactor.self) { r in
            return ManagementReactor(
                fetchManagementClubUseCase: r.resolve(FetchManagementClubUseCase.self)!
            )
        }
        self.register(AlarmReactor.self) { r in
            return AlarmReactor(
                fetchNoticeListUseCase: r.resolve(FetchNoticeListUseCase.self)!
            )
        }
        self.register(MyPageReactor.self) { r in
            return MyPageReactor(
                fetchUserInfoUseCase: r.resolve(FetchUserInfoUseCase.self)!
            )
        }
        self.register(LoginReactor.self) { r in
            return LoginReactor(
            )
        }
    }
}
