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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.6.0/lefthook.artifactbundle.zip",
            checksum: "9bf59a96b6dc399c14117af71ce4fc8e992b258d9e8f51eac4a70b52d2ff8eb1"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
