import ProjectDescription

extension TargetDependency{
    public struct SPM {}
}

public extension TargetDependency.SPM{
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RxMoya = TargetDependency.external(name: "RxMoya")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let RxFlow = TargetDependency.external(name: "RxFlow")
    static let FCM = TargetDependency.external(name: "FirebaseMessaging")
    static let Then = TargetDependency.external(name: "Then")
    static let IQKeyboardManager = TargetDependency.external(name: "IQKeyboardManagerSwift")
    static let ReactorKit = TargetDependency.external(name: "ReactorKit")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let RxDataSources = TargetDependency.external(name: "RxDataSources")
    static let Reusable = TargetDependency.external(name: "Reusable")
    static let BTImageView = TargetDependency.external(name: "BTImageView")
    static let RxGesture = TargetDependency.external(name: "RxGesture")
    static let PanModal = TargetDependency.external(name: "PanModal")
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let ViewAnimator = TargetDependency.external(name: "ViewAnimator")
    static let Quick = TargetDependency.external(name: "Quick")
    static let Nimble = TargetDependency.external(name: "Nimble")
    static let DPOTPView = TargetDependency.external(name: "DPOTPView")
    static let Tabman = TargetDependency.external(name: "Tabman")
    static let RxKeyboard = TargetDependency.external(name: "RxKeyboard")
    static let Loaf = TargetDependency.external(name: "Loaf")
    static let ParkedTextField = TargetDependency.external(name: "ParkedTextField")
    static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
    static let Inject = TargetDependency.external(name: "Inject")
    static let Realm = TargetDependency.external(name: "Realm")
    static let RealmSwift = TargetDependency.external(name: "RealmSwift")
    static let MSGLayout = TargetDependency.external(name: "MSGLayout")
}

public extension Package {
}
