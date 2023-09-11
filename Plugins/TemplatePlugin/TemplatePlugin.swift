//
//  TemplatePlugin.swift
//  GigaBitcoin/template-plugin
//
//  Copyright (c) 2023 GigaBitcoin LLC
//  Distributed under the MIT software license
//
//  See the accompanying file LICENSE for information
//

import Foundation
import PackagePlugin

@main
struct TemplatePlugin: CommandPlugin {
    func performCommand(
        context: PackagePlugin.PluginContext,
        arguments: [String]
    ) async throws {
        let binary = try context.tool(named: "template")
        let process = Process()

        process.executableURL = URL(filePath: binary.path.string)
        process.arguments = arguments

        try process.run()
        process.waitUntilExit()

        // Check whether the `template` invocation was successful.
        guard process.terminationReason == .exit && process.terminationStatus == 0 else {
            Diagnostics.error("""
                'template' invocation failed with a nonzero exit code: '\(process.terminationStatus)'.

                See 'swift package plugin template --help' for details.
                """
            )

            return
        }
    }
}
