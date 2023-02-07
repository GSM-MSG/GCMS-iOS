import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "Service",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
    settings: .settings(base: SettingsDictionary(),
                        configurations: [
                            .debug(name: .debug, xcconfig: .relativeToXCConfig(type: .debug, name: "Service")),
                            .release(name: .release, xcconfig: .relativeToXCConfig(type: .release, name: "Service"))
                        ],
                        defaultSettings: .recommended)
)
