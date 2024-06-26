import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .Realm,
        .Firebase,
        .IQKeyboardManager
    ],
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: [
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
        .SPM.ViewAnimator,
        .SPM.DPOTPView,
        .SPM.Tabman,
        .SPM.RxKeyboard,
        .SPM.Loaf,
        .SPM.ParkedTextField,
        .SPM.Inject,
        .SPM.Realm,
        .SPM.RealmSwift,
        .SPM.MSGLayout,
        .SPM.GAuthSignin,
        .SPM.Configure
    ]
)
