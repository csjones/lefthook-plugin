// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "lefthook",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "lefthook", targets: ["LefthookExecutable"]),
        .plugin(name: "LefthookPlugin",targets: ["LefthookPlugin"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "LefthookExecutable",
            plugins: [
                .plugin(name: "ArtifactExpander")
            ]
        ),
        .plugin(
            name: "ArtifactExpander",
            capability: .buildTool(),
            dependencies: ["lefthook"]
        ),
        .plugin(
            name: "LefthookPlugin",
            capability: .command(
                intent: .custom(
                    verb: "lefthook",
                    description: "Execute commands defined in lefthook.yml."
                )
            ),
            dependencies: ["lefthook"]
        ),
        .binaryTarget(
            name: "lefthook",
            url: "https://github.com/csjones/lefthook-plugin/releases/download/2.1.16/lefthook.artifactbundle.zip",
            checksum: "0eabf8271d30698f969c96f3b61a7bc0f7816177270036019cf52cd722acb120"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
