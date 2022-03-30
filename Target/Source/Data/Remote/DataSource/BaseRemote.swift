import Foundation
import Moya
import RxSwift

class BaseRemote<API: MoizaAPI> {
    private lazy var provider = MoyaProvider<API>(plugins: [JWTPlugin()])
    private lazy var testingEndpoing = { (target: MoizaAPI) -> Endpoint in
        return Endpoint(
            url: "\(target.baseURL.absoluteURL)\(target.path)",
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    private lazy var testingProvider = MoyaProvider<API>(endpointClosure: testingEndpoing, plugins: [JWTPlugin()])
    
    func request(_ api: API, isTest: Bool = false) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            if self.checkApiIsNeedAccessToken(api) {
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
        return (isTest ? testingProvider : provider).rx.request(api, callbackQueue: .main)
            .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let errorCode = (error as? MoyaError)?.response?.statusCode else {
                    return Single.error(error)
                }
                return Single.error(MoizaError.error(errorBody: ["status": errorCode]))
            }
    }
    func requestWithAccessToken(_ api: API, isTest: Bool = false) -> Single<Response> {
        return Single.deferred {
            do {
                if try self.checkTokenIsNotExpired() {
                    return self.defaultRequest(api, isTest: isTest)
                } else {
                    return .error(TokenError.tokenExpired)
                }
            } catch {
                return .error(error)
            }
        }
        .retry(when: { (errorObservable: Observable<TokenError>) in
            return errorObservable
                .flatMap { error -> Observable<Void> in
                    switch error {
                    case .tokenExpired:
                        return self.reissueToken()
                            .andThen(.just(()))
                    case .noToken:
                        return .error(error)
                    }
                }
        })
    }
    
    func checkApiIsNeedAccessToken(_ api: API) -> Bool {
        return api.jwtTokenType == .accessToken
    }
    func checkTokenIsNotExpired() throws -> Bool {
        do {
            let expired = try KeychainLocal.shared.fetchExpiredAt()
            return Date() <= expired
        } catch {
            throw TokenError.noToken
        }
    }
    func reissueToken() -> Completable {
        return MoyaProvider<AuthAPI>(plugins: [JWTPlugin()])
            .rx
            .request(.reissue)
            .asCompletable()
    }
}
