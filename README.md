# lefthook-plugin

A Swift Package that integrates [lefthook](https://github.com/evilmartians/lefthook), a fast and powerful Git hooks manager, into the Swift ecosystem. 

## Features

- **Fast Execution**: Written in Go, lefthook can run commands in parallel.
- **Powerful Configuration**: Control execution and the files you pass to your commands.
- **Swift Integration**: Seamlessly integrates with Swift projects through the Swift Package Manager.
- **Mint support**: Run lefthook using [mint](https://github.com/yonaskolb/Mint), a package manager for Swift CLI tools. 

## Installation

### Using Swift Package Manager plugin 

To utilize the `lefthook-plugin`, include it in the target specification of your Swift Package:

```swift
// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
        .package(url: "https://github.com/csjones/lefthook-plugin.git", exact: "1.10.3"),
    ],
    targets: [
        .executableTarget(name: "YourTargetName")
    ]
)
```

This configuration ensures that SPM invokes the plugin, thereby integrating lefthook's capabilities into your Swift project.

### Using [mint](https://github.com/yonaskolb/Mint)

```
$ mint install csjones/lefthook-plugin
```

## Commands

After `lefthook` is [installed](#installation) in your Swift project, it's time to run it. 

### Using Swift Package Manager plugin 

Invoke the plugin directly using the `swift package plugin` CLI:

```bash
swift package lefthook --help
```

Run `lefthook install` to initialize a lefthook.yml config and/or synchronize `.git/hooks/` with your configuration.

```bash
swift package --disable-sandbox lefthook install
```

> [!IMPORTANT]  
> The lefthook plugin necessitates the `--disable-sandbox` flag with the Swift Package Manager due to its requirement for local document access to read files.

To execute the lefthook plugin within your package repository:

```bash
swift package --disable-sandbox lefthook run pre-commit
```

> [!NOTE]
> For a detailed understanding of lefthook's commands and their usage, refer to [lefthook's official usage documentation](https://github.com/evilmartians/lefthook/blob/master/docs/usage.md).

### Using `mint`

After running `mint install csjones/lefthook-plugin` to install the CLI tool, anytime you want to interact with `lefthook`, all you have to do is run `mint run csjones/lefthook-plugin <command>`. Example: `mint run csjones/lefthook-plugin --help`. 

## Configuration

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

> [!TIP]
> For a comprehensive understanding and more advanced configurations, refer to [lefthook's official configuration documentation](https://github.com/evilmartians/lefthook/blob/master/docs/configuration.md).

## Community and Support

If you encounter any issues or have questions regarding the `lefthook-plugin`, please open an issue on GitHub. Contributions, suggestions, and feedback are always welcome!

## Acknowledgments

Special thanks to the original [lefthook](https://github.com/evilmartians/lefthook) project and its contributors for creating a powerful Git hooks manager.
