// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "lefthook",
    products: [
        .plugin(
            name: "lefthook",
            targets: [
                "LefthookPlugin"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .plugin(
            name: "LefthookPlugin",
            capability: .command(
                intent: .custom(
                    verb: "lefthook",
                    description: "Execute commands defined in lefthook.yml."
                )
            ),
            dependencies: ["lefthook"],
            path: "Plugin"
        ),
//        .binaryTarget(name: "lefthook", path: "lefthook.artifactbundle.zip"),
        .binaryTarget(
            name: "lefthook",
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.5.6/lefthook.artifactbundle.zip",
            checksum: "b6255f00f539a716ff8c72f94bec47f84fd51c3693d470bfa71b2697316e6ed3"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
