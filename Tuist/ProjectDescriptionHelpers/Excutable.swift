import ProjectDescription

extension Project{
    public static func excutable(
        name: String,
        platform: Platform,
        product: Product = .app,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: [.iphone, .iphone]),
        dependencies: [TargetDependency],
        settings: Settings? = nil
    ) -> Project {
        return Project(
            name: name,
            organizationName: publicOrganizationName,
            settings: .settings(base: .codeSign),
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: product,
                    bundleId: "\(publicOrganizationName).\(name)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .file(path: Path("Support/Info.plist")),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    entitlements: Path("Support/\(name).entitlements"),
                    dependencies: [
                        .project(target: "ThirdPartyLib", path: Path("../ThirdPartyLib")),
                    ] + dependencies,
                    settings: settings
                ),
                Target(
                    name: "\(name)Test",
                    platform: platform,
                    product: .unitTests,
                    bundleId: "\(publicOrganizationName).\(name)Test",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["Tests/**"],
                    dependencies: [
                        .SPM.Quick,
                        .SPM.Nimble,
                        .SPM.ReactorKit,
                        .target(name: name)
                    ]
                )
            ]
        )
    }
}
