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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/2.1.17/lefthook.artifactbundle.zip",
            checksum: "1d3ccede9b70d3fca81e17d5419ac65af34ce0c8bc54000256907b352ad4ebd5"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
