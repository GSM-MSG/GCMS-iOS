import ProjectDescription

extension TargetDependency{
    public struct SPM {}
}

public extension TargetDependency.SPM{
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxMoya = TargetDependency.package(product: "RxMoya")
    static let SnapKit = TargetDependency.package(product: "SnapKit")
    static let Swinject = TargetDependency.package(product: "Swinject")
    static let RxFlow = TargetDependency.package(product: "RxFlow")
    static let FCM = TargetDependency.package(product: "FirebaseMessaging")
    static let Then = TargetDependency.package(product: "Then")
    static let IQKeyboardManager = TargetDependency.package(product: "IQKeyboardManagerSwift")
    static let ReactorKit = TargetDependency.package(product: "ReactorKit")
    static let Kingfisher = TargetDependency.package(product: "Kingfisher")
    static let RxDataSources = TargetDependency.package(product: "RxDataSources")
    static let Reusable = TargetDependency.package(product: "Reusable")
    static let BTImageView = TargetDependency.package(product: "BTImageView")
    static let RxGesture = TargetDependency.package(product: "RxGesture")
    static let PanModal = TargetDependency.package(product: "PanModal")
    static let Lottie = TargetDependency.package(product: "Lottie")
    static let ViewAnimator = TargetDependency.package(product: "ViewAnimator")
    static let Quick = TargetDependency.package(product: "Quick")
    static let Nimble = TargetDependency.package(product: "Nimble")
    static let DPOTPView = TargetDependency.package(product: "DPOTPView")
    static let Tabman = TargetDependency.package(product: "Tabman")
    static let RxKeyboard = TargetDependency.package(product: "RxKeyboard")
    static let Loaf = TargetDependency.package(product: "Loaf")
    static let ParkedTextField = TargetDependency.package(product: "ParkedTextField")
    static let GoogleSignIn = TargetDependency.package(product: "GoogleSignIn")
    static let Inject = TargetDependency.package(product: "Inject")
    static let Realm = TargetDependency.package(product: "Realm")
    static let RealmSwift = TargetDependency.package(product: "RealmSwift")
    static let MSGLayout = TargetDependency.package(product: "MSGLayout")
}

public extension Package {
}
