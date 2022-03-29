import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .RxFlow,
        .Firebase,
        .Moya,
        .IQKeyboardManager,
        .ReactorKit,
        .SnapKit,
        .Swinject,
        .Then,
        .Kingfisher,
        .RxDataSources,
        .Lottie,
        .Reusable,
        .BTImageView,
        .RxGesture,
        .PanModal,
        .ViewAnimator,
        .Quick,
        .Nimble
    ],
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.Then,
        .SPM.FCM,
        .SPM.Swinject,
        .SPM.SnapKit,
        .SPM.ReactorKit,
        .SPM.IQKeyboardManager,
        .SPM.RxFlow,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Kingfisher,
        .SPM.RxDataSources,
        .SPM.Lottie,
        .SPM.Reusable,
        .SPM.BTImageView,
        .SPM.RxGesture,
        .SPM.PanModal,
        .SPM.ViewAnimator
    ]
)
