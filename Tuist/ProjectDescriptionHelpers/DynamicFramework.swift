import ProjectDescription

extension Project{
    public static func dynamicFramework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency] = [
            .project(target: "ThirdPartyLib", path: Path("../ThirdPartyLib"))
        ]
    ) -> Project {
        return Project(
            name: name,
            packages: packages,
            settings: .settings(base: .codeSign, configurations: [
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
                    resources: ["Resources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }
}
