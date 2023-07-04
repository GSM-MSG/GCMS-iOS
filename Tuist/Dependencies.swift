import ProjectDescription

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .exact("6.5.0")),
            .remote(url: "https://github.com/GSM-MSG/Moya.git", requirement: .branch("master")),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .exact("5.6.0")),
            .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .exact("2.8.3")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxFlow.git", requirement: .exact("2.13.0")),
            .remote(url: "https://github.com/ReactorKit/ReactorKit.git", requirement: .exact("3.2.0")),
            .remote(url: "https://github.com/devxoul/Then.git", requirement: .exact("3.0.0")),
            .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .exact("7.6.2")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .exact("5.0.2")),
            .remote(url: "https://github.com/AliSoftware/Reusable.git", requirement: .exact("4.1.2")),
            .remote(url: "https://github.com/baekteun/BTImageView.git", requirement: .exact("1.1.2")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .exact("4.0.4")),
            .remote(url: "https://github.com/slackhq/PanModal.git", requirement: .exact("1.2.7")),
            .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .exact("4.1.2")),
            .remote(url: "https://github.com/marcosgriselli/ViewAnimator.git", requirement: .exact("3.1.0")),
            .remote(url: "https://github.com/Quick/Quick.git", requirement: .exact("6.1.0")),
            .remote(url: "https://github.com/Quick/Nimble.git", requirement: .exact("11.2.1")),
            .remote(url: "https://github.com/Datt1994/DPOTPView.git", requirement: .exact("1.5.12")),
            .remote(url: "https://github.com/uias/Tabman.git", requirement: .exact("3.0.1")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard.git", requirement: .exact("2.0.0")),
            .remote(url: "https://github.com/schmidyy/Loaf", requirement: .exact("0.6.0")),
            .remote(url: "https://github.com/gmertk/ParkedTextField", requirement: .exact("1.0.0")),
            .remote(url: "https://github.com/krzysztofzablocki/Inject.git", requirement: .exact("1.2.2")),
            .remote(url: "https://github.com/GSM-MSG/MSGLayout.git", requirement: .exact("1.1.0")),
            .remote(url: "https://github.com/GSM-MSG/GAuthSignin-Swift.git", requirement: .exact("0.0.3"))
        ],
        productTypes: [
            "ReactorKit": .framework,
            "ReactorKitRuntime": .framework,
            "GAuthSignin": .framework
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ]
        )
    ),
    platforms: [.iOS]
)
