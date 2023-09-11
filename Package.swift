// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "template",
    products: [
        .plugin(
            name: "template",
            targets: [
                "TemplatePlugin"
            ]
        )
    ],
    dependencies: [],
    targets: [
        .plugin(
            name: "TemplatePlugin",
            capability: .command(
                intent: .custom(
                    verb: "template",
                    description: "Execute commands defined by template."
                )
            ),
            dependencies: ["template"]
        ),
//        .binaryTarget(name: "template", path: "template.artifactbundle.zip"),
        .binaryTarget(
            name: "template",
            url: "https://github.com/GigaBitcoin/template-plugin/releases/download/0.0.1/template.artifactbundle.zip",
            checksum: "42e1e7a4f7d7586ec6d13b3e03cce5612ac237244cc3cb1e6de7c49416d04520"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
