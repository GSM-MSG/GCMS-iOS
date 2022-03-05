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
        .Hero,
        .GoogleSignIn,
        .Kingfisher,
        .RxDataSources,
        .PinLayout,
        .Reusable,
        .BTImageView,
        .RxGesture,
        .PanModal
    ],
    deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
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
        .SPM.Hero,
        .SPM.GoogleSignIn,
        .SPM.Kingfisher,
        .SPM.RxDataSources,
        .SPM.PinLayout,
        .SPM.Reusable,
        .SPM.BTImageView,
        .SPM.RxGesture,
        .SPM.PanModal
    ]
)
