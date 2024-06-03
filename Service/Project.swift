import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "Service",
    destinations: .iOS,
    infoPlist: .extendingDefault(
        with: [
            "BASE_URL": "$(BASE_URL)"
        ]
    ),
    deploymentTarget: .iOS("14.0")
)
