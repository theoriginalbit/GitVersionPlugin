import PackagePlugin

@main
struct GitVersionPlugin: BuildToolPlugin {
    /// Entry point for creating build commands for targets in Swift packages.
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        return try [
            createBuildCommand(
                in: context.package.directory,
                outputtingTo: context.pluginWorkDirectory,
                tool: context.tool(named: "GitStatus")
            ),
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension GitVersionPlugin: XcodeBuildToolPlugin {
    /// Entry point for creating build commands for targets in Xcode projects.
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        return try [
            createBuildCommand(
                in: context.xcodeProject.directory,
                outputtingTo: context.pluginWorkDirectory,
                tool: context.tool(named: "GitStatus")
            ),
        ]
    }
}

#endif

extension GitVersionPlugin {
    func createBuildCommand(in rootPath: Path, outputtingTo outputPath: Path, tool: PluginContext.Tool) -> Command {
        let generatedSourceFile = outputPath.appending("LibraryVersion.swift")
        // Return a command that will run during the build to generate the LibraryVersion file.
        return .buildCommand(
            displayName: "Getting package repository state",
            executable: tool.path,
            arguments: [rootPath, generatedSourceFile],
            outputFiles: [generatedSourceFile]
        )
    }
}
