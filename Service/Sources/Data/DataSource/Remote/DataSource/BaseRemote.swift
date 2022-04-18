import Moya
import Foundation
import RxSwift
import RxMoya
import AVFoundation

class BaseRemote<API: GCMSAPI> {
    public var testStatus = false
    public var successStatus = true
    private let provider = MoyaProvider<API>(plugins: [JWTPlugin()])
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
            .catch { error in
                guard let moyaErr = error as? MoyaError else {
                    return .error(error)
                }
                
                return .error(api.errorMapper?[moyaErr.response?.statusCode ?? 400] ?? error)
            }
    }
    
    func requestWithAccessToken(_ api: API) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            do {
                if try self.checkTokenIsValid() {
                    disposables.append(
                        self.defaultRequest(api)
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
            return Date() > expired
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
