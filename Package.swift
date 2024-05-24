// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", exact: "6.5.0"),
        .package(url: "https://github.com/Moya/Moya.git", exact: "15.0.3"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.6.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", exact: "2.8.3"),
        .package(url: "https://github.com/RxSwiftCommunity/RxFlow.git", exact: "2.13.0"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", exact: "3.2.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.7.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", exact: "5.0.2"),
        .package(url: "https://github.com/AliSoftware/Reusable.git", exact: "4.1.2"),
        .package(url: "https://github.com/baekteun/BTImageView.git", exact: "1.1.2"),
        .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git", exact: "4.0.4"),
        .package(url: "https://github.com/slackhq/PanModal.git", exact: "1.2.7"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", exact: "4.1.2"),
        .package(url: "https://github.com/marcosgriselli/ViewAnimator.git", exact: "3.1.0"),
        .package(url: "https://github.com/Quick/Quick.git", exact: "6.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", exact: "11.2.1"),
        .package(url: "https://github.com/Datt1994/DPOTPView.git", exact: "1.5.12"),
        .package(url: "https://github.com/uias/Tabman.git", exact: "3.2.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxKeyboard.git", exact: "2.0.0"),
        .package(url: "https://github.com/schmidyy/Loaf", exact: "0.6.0"),
        .package(url: "https://github.com/gmertk/ParkedTextField", exact: "1.0.0"),
        .package(url: "https://github.com/krzysztofzablocki/Inject.git", exact: "1.2.2"),
        .package(url: "https://github.com/GSM-MSG/MSGLayout.git", exact: "1.1.0"),
        .package(url: "https://github.com/GSM-MSG/GAuthSignin-Swift.git", exact: "0.0.3"),
        .package(url: "https://github.com/GSM-MSG/Configure.git", from: "1.0.0"),
    ]
)
