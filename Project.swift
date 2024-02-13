import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .PrettyCards,
    additionalBaseSettings: SettingsDictionary().allowAppExtensionAPIOnly(true),
    targets: [
        .target(
            name: .PrettyCards
        ),
        .target(
            name: .PrettyCardsTests,
            product: .unitTests,
            sources: .defaultTestsPath,
            dependencies: [.target(name: .PrettyCards)]
        )
    ],
    additionalFiles: ["README.MD", "Package.swift", "PrettyCards.podspec"]
)
