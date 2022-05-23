import Moya
import Foundation
import RxSwift
import RxMoya
import AVFoundation

class BaseRemote<API: GCMSAPI> {
    public var testStatus = false
    public var successStatus = true
    private let provider = MoyaProvider<API>(plugins: [JWTPlugin(), NetworkLoggerPlugin()])
    private let successTestEndpoint = { (target: API) -> Endpoint in
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(201, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    private let failureTestEndPoint = { (target: API) -> Endpoint in
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(401, Data())},
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers)
    }
    private var testingProvider: MoyaProvider<API>!
    
    func request(_ api: API) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            if self.isApiNeedsAccessToken(api) {
                disposables.append(
                    self.requestWithAccessToken(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            } else {
                disposables.append(
                    self.defaultRequest(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            }
            return Disposables.create(disposables)
        }
    }
}

private extension BaseRemote {
    func defaultRequest(_ api: API) -> Single<Response> {
        if testStatus {
            testingProvider = MoyaProvider<API>(endpointClosure: successStatus ? successTestEndpoint : failureTestEndPoint, stubClosure: MoyaProvider.delayedStub(1.5))
        }
        
        return (testStatus ? testingProvider : provider).rx
            .request(api)
            .timeout(.seconds(120), scheduler: MainScheduler.asyncInstance)
            .do(onSuccess: {
                print(try? $0.mapJSON())
            })
            .catch { error in
                guard let code = (error as? MoyaError)?.response?.statusCode else {
                    return .error(error)
                }
                if code == 401 && API.self != AuthAPI.self {
                    return self.reissueToken()
                        .andThen(.error(TokenError.expired))
                }
                return .error(api.errorMapper?[code] ?? error)
            }
    }
    
    func requestWithAccessToken(_ api: API) -> Single<Response> {
        return .deferred {
            do {
                if try self.checkTokenIsValid() {
                    return self.defaultRequest(api)
                } else {
                    return .error(TokenError.expired)
                }
            } catch {
                return .error(error)
            }
        }
        .retry(when: { (errorObservable: Observable<TokenError>) in
            return errorObservable
                .flatMap { error -> Observable<Void> in
                    switch error {
                    case .expired:
                        return self.reissueToken()
                            .andThen(.just(()))
                    default:
                        return .error(error)
                    }
                }
        })
        .retry(2)
    }
    
    func isApiNeedsAccessToken(_ api: API) -> Bool {
        return api.jwtTokenType == .accessToken
    }
    func checkTokenIsValid() throws -> Bool {
        do {
            let expired = try KeychainLocal.shared.fetchExpiredAt().toDateWithISO8601().addingTimeInterval(60 * 60 * 9)
            return Date() < expired
        } catch {
            throw TokenError.noData
        }
    }
    func reissueToken() -> Completable {
        return AuthRemote.shared.refresh()
    }
}
