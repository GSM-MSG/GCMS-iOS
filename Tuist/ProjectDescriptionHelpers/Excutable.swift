import ProjectDescription

extension Project{
    public static func makeModule(
        name: String,
        destinations: Destinations = .iOS,
        product: Product = .app,
        deploymentTarget: DeploymentTargets = .iOS("15.0"),
        dependencies: [TargetDependency],
        resources: ResourceFileElements? = nil,
        settings: Settings? = nil
    ) -> Project {
        return Project(
            name: name,
            organizationName: publicOrganizationName,
            settings: .settings(base: .codeSign.merging([
                "MARKETING_VERSION": "1.0",
                "CURRENT_PROJECT_VERSION": "1.0"
            ]), configurations: isCI ?
                                [
                                    .debug(name: .debug),
                                    .release(name: .release)
                                ] :
                                [
                                    .debug(name: .debug, xcconfig: .relativeToXCConfig(type: .debug, name: name)),
                                    .release(name: .release, xcconfig: .relativeToXCConfig(type: .release, name: name))
                                ]),
            targets: [
                .target(
                    name: name,
                    destinations: destinations,
                    product: product,
                    bundleId: "\(publicOrganizationName).\(name)",
                    deploymentTargets: deploymentTarget,
                    infoPlist: .file(path: Path("Support/Info.plist")),
                    sources: ["Sources/**"],
                    resources: resources,
                    entitlements: .file(path: Path("Support/\(name).entitlements")),
                    dependencies: [
                        .project(target: "ThirdPartyLib", path: Path("../ThirdPartyLib")),
                    ] + dependencies,
                    settings: settings
                ),
                .target(
                    name: "\(name)Test",
                    destinations: destinations,
                    product: .unitTests,
                    bundleId: "\(publicOrganizationName).\(name)Test",
                    deploymentTargets: deploymentTarget,
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
