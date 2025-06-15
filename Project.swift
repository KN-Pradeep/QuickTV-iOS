@preconcurrency import ProjectDescription

private let bundleIdPrefix = "in.mohalla.QuickTV"
private let appVersion = "1.0.0"
private let bundleVersion = "1"
private let appName = "QuickTV"
private let iOSTargetVersion = "15.0"

private let basePath = "QuickTV"


let project = Project(
    name: appName,
    packages: [],
    settings: Settings.settings(configurations: makeConfiguration()),
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleIdPrefix,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: makeInfoPlist(),
            sources: ["\(basePath)/Sources/**"],
            resources: ["\(basePath)/Resources/**"],
            entitlements: "\(basePath)/Resources/QuickTV.entitlements",
            dependencies: [],
            settings: baseSettings()
        ),
        .target(
            name: "QuickTVTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.QuickTVTests",
            infoPlist: .default,
            sources: ["QuickTV/Tests/**"],
            resources: [],
            dependencies: [.target(name: "QuickTV")]
        ),
    ],
    additionalFiles: [
        "README.md"
    ]
)

private func makeInfoPlist() -> InfoPlist {
    return InfoPlist.extendingDefault(with: [
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "UILaunchStoryboardName": "LaunchScreen.storyboard",
        "NSMicrophoneUsageDescription": "This app requires access to the microphone for playing audio."
])
}

private func makeConfiguration() -> [Configuration] {
    let debug: Configuration = Configuration.debug(
        name: "Debug", xcconfig: "Config/Debug.xcconfig"
    )
    let release: Configuration = Configuration.debug(
        name: "Release", xcconfig: "Config/Release.xcconfig"
    )
    
    return [debug, release]
}

private func baseSettings() -> Settings {
    var settings = SettingsDictionary()
    return Settings.settings(
        base: settings,
        configurations: makeConfiguration(),
        defaultSettings: .recommended
    )
}
