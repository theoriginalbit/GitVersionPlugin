# GitVersionPlugin

A SwiftPM plugin that codegens a version number, as read by Git, for use in tooling

Split from [Apple's swift-testing repo](https://github.com/apple/swift-testing/blob/7f39433a0a78ccc92b541597c542b70f68de75e6/Sources/GitStatus/main.swift) and Xcode plugin added to the interface.

The version is determined from:
- If the repository is sitting at a tag with no uncommitted changes, use the tag.
- Otherwise, use the commit hash (with a "there are changes" marker if needed.)
- Finally, fall back to nil if nothing else is available.
