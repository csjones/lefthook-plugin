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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.5.3/lefthook.artifactbundle.zip",
            checksum: "2d9d24b27c0b63aaa58b35bc9552941be5cd73b5c7c85a89c1227db2dc9ee101"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
