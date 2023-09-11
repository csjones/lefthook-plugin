# lefthook-plugin

A Swift Plugin that integrates [lefthook](https://github.com/evilmartians/lefthook), a fast and powerful Git hooks manager, into the Swift Package Manager (SPM) ecosystem. Incorporate `lefthook-plugin` into your `Package.swift` dependencies to utilize lefthook in your Swift projects.

## Features

- **Fast Execution**: Written in Go, lefthook can run commands in parallel.
- **Powerful Configuration**: Control execution and the files you pass to your commands.
- **Swift Integration**: Seamlessly integrates with Swift projects through the Swift Package Manager.

## Overview

The Swift Package Manager offers extensibility through plugins. The `lefthook-plugin` leverages the `PackagePlugin` API from the Swift Package Manager, providing a seamless bridge to incorporate lefthook functionalities into Swift projects.

## Installation

### Integrating the lefthook-plugin

To utilize the `lefthook-plugin`, include it in the target specification of your Swift Package:

```swift
// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
        .package(url: "https://github.com/csjones/lefthook-plugin.git", from: "1.4.11"),
    ],
    targets: [
        .executableTarget(name: "YourTargetName")
    ]
)
```

This configuration ensures that SPM invokes the plugin, thereby integrating lefthook's capabilities into your Swift project.

### Commands

Invoke the plugin directly using the `swift package plugin` CLI:

```bash
swift package plugin lefthook --help
```

To execute the lefthook plugin within your package repository:

```bash
swift package --disable-sandbox plugin lefthook run pre-commit
```

> **Note**: The lefthook plugin necessitates the `--disable-sandbox` flag with the Swift Package Manager due to its requirement for local document access to read files.

For a detailed understanding of lefthook's commands and their usage, refer to [lefthook's official usage documentation](https://github.com/evilmartians/lefthook/blob/master/docs/usage.md).

### Configuration

Below is a sample configuration for lefthook:

```yml
pre-push:
  commands:
    1_test:
      run: swift test

pre-commit:
  commands:
    1_swiftformat:
      glob: "*.{swift}"
      run: swift run swiftformat --config .swiftformat {all_files}
    2_swiftlint:
      glob: "*.{swift}"
      run: swift run swiftlint --autocorrect --strict --no-cache
    3_git:
      run: git add .
```

For a comprehensive understanding and more advanced configurations, refer to [lefthook's official configuration documentation](https://github.com/evilmartians/lefthook/blob/master/docs/configuration.md).

## Community and Support

If you encounter any issues or have questions regarding the `lefthook-plugin`, please open an issue on GitHub. Contributions, suggestions, and feedback are always welcome!

## Acknowledgments

Special thanks to the original [lefthook](https://github.com/evilmartians/lefthook) project and its contributors for creating a powerful Git hooks manager.
