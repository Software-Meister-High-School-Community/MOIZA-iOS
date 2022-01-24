import ProjectDescription

let projectName = "MOIZA"
let orginazationIden = "com.connect"

let project = Project(
    name: projectName,
    organizationName: orginazationIden,
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "\(orginazationIden).\(projectName)",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
            infoPlist: .file(path: Path("Target/Support/Info.plist")),
            sources: ["Target/Source/**"],
            resources: ["Target/Resource/**"]
        ),
        Target(
            name: "\(projectName)Test",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(orginazationIden).\(projectName)Test",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
            infoPlist: .default,
            sources: ["TargetTest/Tests/**"],
            dependencies: [
                .target(name: projectName)
            ]
        ),
        Target(
            name: "\(projectName)UITest",
            platform: .iOS,
            product: .uiTests,
            bundleId: "\(orginazationIden).\(projectName)UITest",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
            infoPlist: .default,
            sources: ["TargetUITest/Tests/**"],
            dependencies: [
                .target(name: projectName)
            ]
        )
    ]
)
