import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "MOIZA"
let orginazationIden = "com.connect"

let project = Project.excutable(
    name: projectName,
    platform: .iOS,
    product: .app,
    deploymentTarget: .iOS(targetVersion: "13.5", devices: [.iphone, .ipad]),
    dependencies: []
)
