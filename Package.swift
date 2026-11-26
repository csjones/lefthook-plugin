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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/2.2.4/lefthook.artifactbundle.zip",
            checksum: "0bf32fe8a22079f266e50c517b5c95aec444f42d12aad8e38bb65a6be6629a28"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
