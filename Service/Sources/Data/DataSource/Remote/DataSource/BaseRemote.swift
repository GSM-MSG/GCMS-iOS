import Moya
import Foundation
import RxSwift
import RxMoya
import AVFoundation
import Alamofire

class BaseRemote<API: GCMSAPI> {
    #if DEBUG
    private let provider = MoyaProvider<API>(plugins: [JWTPlugin(), GCMSLoggingPlugin()])
    #else
    private let provider = MoyaProvider<API>(plugins: [JWTPlugin()])
    #endif

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
        return provider.rx
            .request(api)
            .timeout(.seconds(120), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let host = Bundle.module.object(forInfoDictionaryKey: "BASE_URL") as? String else {
                    return .error(GCMSError.noInternet)
                }
                if (NetworkReachabilityManager(host: host)?.isReachable ?? false) == false {
                    return .error(GCMSError.noInternet)
                }
                guard let code = (error as? MoyaError)?.response?.statusCode else {
                    return .error(error)
                }
                if code == 401 && API.self != AuthAPI.self {
                    return self.reissueToken()
                        .andThen(.error(TokenError.expired))
                }
                return .error(api.errorMapper?[code] ?? GCMSError.error(message: (try? (error as? MoyaError)?.response?.mapJSON() as? NSDictionary)?["message"] as? String ?? "", errorBody: [:]))
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
    }

    func isApiNeedsAccessToken(_ api: API) -> Bool {
        return api.jwtTokenType == .accessToken
    }
    func checkTokenIsValid() throws -> Bool {
        do {
            let expired = try KeychainLocal.shared.fetchAccessExp().toDateWithISO8601()
            print(Date(), expired)
            return Date() < expired
        } catch {
            throw TokenError.noData
        }
    }
    func reissueToken() -> Completable {
        return AuthRemote.shared.refresh()
    }
}
