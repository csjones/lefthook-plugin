//
//  ArtifactExpander.swift
//  csjones/lefthook-plugin
//
//  Copyright (c) 2024 GigaBitcoin LLC
//  Distributed under the MIT software license
//
//  See the accompanying file LICENSE for information
//

import PackagePlugin

@main
struct ArtifactExpander: BuildToolPlugin {
    /// This plugin's implementation returns a single `prebuild` command to expands the `lefthook` artifacts.
    func createBuildCommands(
        context: PackagePlugin.PluginContext,
        target: any PackagePlugin.Target
    ) async throws -> [PackagePlugin.Command] {
        // Return a command to run `lefthook` as a prebuild command. It will be run before
        // every build and have SPM automatically expand the artifact's bundle by unzipping
        // the content into the `.build/artifacts` directory.
        return [
            .prebuildCommand(
                displayName: " - Expanding Lefthook Artifacts - ",
                executable: try context.tool(named: "lefthook").path,
                arguments: [],
                environment: [:],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}
