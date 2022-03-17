import RxSwift

final class ClubRemote: BaseRemote<ClubAPI> {
    static let shared = ClubRemote()
    private override init() {}
    
    
}
