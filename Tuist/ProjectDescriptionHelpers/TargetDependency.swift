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
    static let Hero = TargetDependency.package(product: "Hero")
    static let GoogleSignIn = TargetDependency.package(product: "GoogleSignIn")
    static let Kingfisher = TargetDependency.package(product: "Kingfisher")
    static let RxDataSources = TargetDependency.package(product: "RxDataSources4")
}

public extension Package {
    static let RxSwift = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift",
        requirement: .upToNextMajor(from: "6.2.0")
    )
    static let Moya = Package.remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .upToNextMajor(from: "15.0.0")
    )
    static let SnapKit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .upToNextMajor(from: "5.0.1")
    )
    static let Swinject = Package.remote(
        url: "https://github.com/Swinject/Swinject.git",
        requirement: .upToNextMajor(from: "2.7")
    )
    static let RxFlow = Package.remote(
        url: "https://github.com/RxSwiftCommunity/RxFlow.git",
        requirement: .upToNextMajor(from: "2.12.4")
    )
    static let ReactorKit = Package.remote(
        url: "https://github.com/ReactorKit/ReactorKit.git",
        requirement: .upToNextMajor(from: "3.1.0")
    )
    static let IQKeyboardManager = Package.remote(
        url: "https://github.com/hackiftekhar/IQKeyboardManager.git",
        requirement: .upToNextMajor(from: "6.5.9")
    )
    static let Then = Package.remote(
        url: "https://github.com/devxoul/Then.git",
        requirement: .upToNextMajor(from: "2.7.0")
    )
    static let Firebase = Package.remote(
        url: "https://github.com/firebase/firebase-ios-sdk.git",
        requirement: .upToNextMajor(from: "8.12.0")
    )
    static let Hero = Package.remote(
        url: "https://github.com/HeroTransitions/Hero.git",
        requirement: .upToNextMajor(from: "1.6.1")
    )
    static let GoogleSignIn = Package.remote(
        url: "https://github.com/google/GoogleSignIn-iOS.git",
        requirement: .upToNextMajor(from: "6.1.0")
    )
    static let Kingfisher = Package.remote(
        url: "https://github.com/onevcat/Kingfisher.git",
        requirement: .upToNextMajor(from: "7.0.0")
    )
    static let RxDataSources = Package.remote(
        url: "https://github.com/RxSwiftCommunity/RxDataSources.git",
        requirement: .upToNextMajor(from: "5.0.0")
    )
}
