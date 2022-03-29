import RxSwift
import Quick
import Nimble
@testable import Service
import ReactorKit
@testable import GCMS

final class LoginReactorSpec: QuickSpec {
    override func spec() {
        var authRepository: AuthRepository!
        var loginUseCase: LoginUseCase!
        var reactor: LoginReactor!
        
        beforeEach {
            authRepository = MockSuccessAuthRepository()
            loginUseCase = LoginUseCase(authRepository: authRepository)
            reactor = LoginReactor(loginUseCase: loginUseCase)
            _ = reactor.state
        }
        describe("an initial state") {
            it("is not loading") {
                expect(reactor.currentState.isLoading).to(beFalse())
            }
            it("is not visiblePassword") {
                expect(reactor.currentState.passwordVisible).to(beFalse())
            }
            it("is not failed to login") {
                expect(reactor.currentState.isLoginFailure).to(beFalse())
            }
            it("is empty email") {
                expect(reactor.currentState.email.isEmpty).to(beTrue())
            }
            it("is empty password") {
                expect(reactor.currentState.password.isEmpty).to(beTrue())
            }
        }
        context("when type emailTextField 'email'") {
            it("email is 'email'") {
                reactor.action.onNext(.updateEmail("email"))
                expect(reactor.currentState.email).to(equal("email"))
            }
        }
        context("when type passwordTextField 'password'") {
            it("password is 'password'") {
                reactor.action.onNext(.updatePassword("password"))
                expect(reactor.currentState.password).to(equal("password"))
            }
        }
        context("when click passwordVisibleButton") {
            it("passwordVisible is toggle") {
                let prevVisible = reactor.currentState.passwordVisible
                reactor.action.onNext(.passwordVisibleButtonDidTap)
                expect(reactor.currentState.passwordVisible).toNot(equal(prevVisible))
            }
        }
        context("when failed to login") {
            it("isLoginFailure is true") {
                reactor.action.onNext(.loginDidFailed)
                expect(reactor.currentState.isLoginFailure).to(beTrue())
            }
        }
        context("when failed to login and after type emailTextField") {
            it("isLoginFailure is false") {
                reactor.action.onNext(.loginDidFailed)
                reactor.action.onNext(.updateEmail("testing"))
                expect(reactor.currentState.isLoginFailure).to(beFalse())
            }
        }
    }
}
