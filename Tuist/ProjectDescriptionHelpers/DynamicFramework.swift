import ProjectDescription
import Foundation

let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

extension Project{
    public static func dynamicFramework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        deploymentTarget: DeploymentTarget,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [
            .project(target: "ThirdPartyLib", path: Path("../ThirdPartyLib"))
        ]
    ) -> Project {
        return Project(
            name: name,
            packages: packages,
            settings: .settings(base: .codeSign, configurations: isCI ?
                                [
                                    .debug(name: .debug),
                                    .release(name: .release)
                                ] :
                                [
                                    .debug(name: .debug, xcconfig: .relativeToXCConfig(type: .debug, name: name)),
                                    .release(name: .release, xcconfig: .relativeToXCConfig(type: .release, name: name))
                                ]),
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: .framework,
                    bundleId: "\(publicOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    resources: resources,
                    dependencies: dependencies
                )
            ]
        )
    }
}
