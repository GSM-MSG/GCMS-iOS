import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "Service",
    platform: .iOS,
    infoPlist: .extendingDefault(
        with: [
            "BASE_URL": "$(BASE_URL)"
        ]
    ),
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad])
)
