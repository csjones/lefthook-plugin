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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.6.4/lefthook.artifactbundle.zip",
            checksum: "b900770849045236e5377d313497979ac329bc8ffcab732183eeb2ceb6bcb328"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
