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
        .SwinjectAutoregistration,
        .Then,
        .Hero
    ],
    deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
    dependencies: [
        .SPM.Then,
        .SPM.FCM,
        .SPM.SwinjectAutoregistration,
        .SPM.Swinject,
        .SPM.SnapKit,
        .SPM.ReactorKit,
        .SPM.IQKeyboardManager,
        .SPM.RxFlow,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Hero
    ]
)
