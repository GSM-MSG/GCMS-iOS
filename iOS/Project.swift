import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.excutable(
    name: "GCMS",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    dependencies: [
        .project(target: "Service", path: "../Service")
    ],
    settings: .settings(base: SettingsDictionary(),
                        configurations: [
                            .debug(name: .debug, xcconfig: .relativeToXCConfig(type: .debug, name: "GCMS")),
                            .release(name: .release, xcconfig: .relativeToXCConfig(type: .release, name: "GCMS"))
                        ],
                        defaultSettings: .recommended)
)
