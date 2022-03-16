import ProjectDescription

extension Project{
    public static func excutable(
        name: String,
        platform: Platform,
        product: Product = .app,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.5", devices: [.iphone, .iphone]),
        dependencies: [TargetDependency]
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
                    infoPlist: .file(path: Path("Target/Support/Info.plist")),
                    sources: ["Target/Source/**"],
                    resources: ["Target/Resource/**"],
                    entitlements: Path("Target/Support/\(name).entitlements")
                ),
                Target(
                    name: "\(name)Test",
                    platform: platform,
                    product: .unitTests,
                    bundleId: "\(publicOrganizationName).\(name)Test",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["TargetTest/Tests/**"],
                    dependencies: [
                        .target(name: name)
                    ]
                )
            ]
        )
    }
}
