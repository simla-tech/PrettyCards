import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .PrettyCards,
    additionalBaseSettings: SettingsDictionary().allowAppExtentionAPIOnly(true),
    targets: [
        Target(
            name: .PrettyCards
        ),
        Target(
            name: .PrettyCardsTests,
            product: .unitTests,
            sources: .defaultTestsPath,
            dependencies: [.target(name: .PrettyCards)]
        )
    ],
    additionalFiles: ["README.MD", "Package.swift", "PrettyCards.podspec"]
)
