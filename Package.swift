// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "lefthook",
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
            url: "https://github.com/csjones/lefthook-plugin/releases/download/1.7.2/lefthook.artifactbundle.zip",
            checksum: "4eb58e1c33e69e7f61a1c6e4d7dbfd8cbed0b17132315588e9e5b38bd0b326af"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
