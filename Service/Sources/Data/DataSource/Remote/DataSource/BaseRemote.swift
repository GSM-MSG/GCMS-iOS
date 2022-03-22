import Moya
import Foundation
import RxSwift
import RxMoya

class BaseRemote<API: GCMSAPI> {
    private lazy var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(), JWTPlugin()])
    private let testingEndpoint = { (target: TargetType) -> Endpoint in
        return Endpoint(
            url: target.baseURL.absoluteString + target.path,
            sampleResponseClosure: { .networkResponse(201, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    private lazy var testingProvider = MoyaProvider<API>(endpointClosure: testingEndpoint, plugins: [JWTPlugin()])
    
    func request(_ api: API, isTest: Bool = false) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            if self.isApiNeedsAccessToken(api) {
                disposables.append(
                    self.requestWithAccessToken(api, isTest: isTest)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            } else {
                disposables.append(
                    self.defaultRequest(api, isTest: isTest)
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
    func defaultRequest(_ api: API, isTest: Bool = false) -> Single<Response> {
        return (isTest ? testingProvider : provider).rx
            .request(api)
            .timeout(.seconds(120), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let moyaErr = error as? MoyaError else {
                    return .error(error)
                }
                return .error(GCMSError.error(errorBody: ["status": moyaErr.response?.statusCode ?? 0]))
            }
    }
    
    func requestWithAccessToken(_ api: API, isTest: Bool = false) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            do {
                if try self.checkTokenIsValid() {
                    disposables.append(
                        self.defaultRequest(api, isTest: isTest)
                            .subscribe(
                                onSuccess: { single(.success($0)) },
                                onFailure: { single(.failure($0)) }
                            )
                    )
                } else {
                    single(.failure(TokenError.noData))
                }
            } catch {
                single(.failure(error))
            }
            return Disposables.create(disposables)
        }.retry { (errorObservable: Observable<TokenError>) in
            errorObservable.flatMap { error -> Completable in
                if error == .expired {
                    return self.reissueToken()
                } else {
                    throw TokenError.noData
                }
            }
        }
    }
    
    func isApiNeedsAccessToken(_ api: API) -> Bool {
        return api.jwtTokenType == .accessToken
    }
    func checkTokenIsValid() throws -> Bool {
        do {
            let expired = try KeychainLocal.shared.fetchExpiredAt().toDateWithISO8601()
            return Date().todayWithGMT() > expired
        } catch {
            throw TokenError.noData
        }
    }
    func reissueToken() -> Completable {
        return MoyaProvider<AuthAPI>(plugins: [JWTPlugin()])
            .rx
            .request(.refresh)
            .asCompletable()
    }
}
