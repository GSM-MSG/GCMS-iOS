import RxSwift

final class UserRemote: BaseRemote<UserAPI> {
    static let shared = UserRemote()
    private override init() {}
    
    func userInfo(isTest: Bool = false) -> Single<UserInfoReesponse> {
        return request(.userInfo, isTest: isTest)
            .map(UserInfoReesponse.self)
    }
    func editPicture(url: String, isTest: Bool = false) -> Completable {
        return request(.editPicture(url: url), isTest: isTest)
            .asCompletable()
    }
    func search(q: String, isTest: Bool = false) -> Single<UserSearchResponse> {
        return request(.search(q), isTest: isTest)
            .map(UserSearchResponse.self)
    }
    func notice(isTest: Bool = false) -> Single<UserNoticeResponse> {
        return request(.notice, isTest: isTest)
            .map(UserNoticeResponse.self)
    }
    func accept(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        return request(.accept(name: name, type: type), isTest: isTest)
            .asCompletable()
    }
    func reject(name: String, type: ClubType, isTest: Bool = false) -> Completable {
        return request(.reject(name: name, type: type), isTest: isTest)
            .asCompletable()
    }
}
