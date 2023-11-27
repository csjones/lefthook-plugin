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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.5.4/lefthook.artifactbundle.zip",
            checksum: "3f9262951c3f973e5d26f5eb52db170a9372223130d5bd4bc8a7a91d491dfc0c"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
