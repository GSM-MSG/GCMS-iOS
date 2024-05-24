import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.makeModule(
    name: "GCMS",
    destinations: .iOS,
    deploymentTarget: .iOS("14.0"),
    dependencies: [
        .project(target: "Service", path: "../Service")
    ],
    resources: ["Resources/**"]
)
